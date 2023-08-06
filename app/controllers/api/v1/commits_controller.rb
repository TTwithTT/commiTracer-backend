module Api
  module V1
    class CommitsController < ApplicationController
      before_action :set_user

      def index
        @commits = @user.commits.order(id: :desc).limit(8)
        render json: @commits, include: [:blocks]
      end

      def create
        @commit = @user.commits.new(commit_params)
        if @commit.save
          render json: @commit, status: :created, location: api_v1_user_commit_url(@user, @commit), include: [:blocks]
        else
          render json: @commit.errors, status: :unprocessable_entity
        end
      end

      def update
        @commit = @user.commits.find(params[:id])
        if @commit.update(commit_params)
          render json: @commit, status: :ok, location: api_v1_user_commit_url(@commit), include: [:blocks]
        else
          render json: @commit.errors, status: :unprocessable_entity
        end
      end

      def destroy
        commit = @user.commits.find(params[:id])
        if commit.destroy
          render json: { status: 'SUCCESS', message: 'Commit deleted', data: commit }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Commit could not be deleted', data: block.errors }, status: :unprocessable_entity
        end
      end

      private

      def commit_params
        params.require(:commit).permit(:id, :title, blocks_attributes: [:id, :name, :length, :status])
      end

      def set_user
        @user = User.find_by(uid: params[:user_id])
        if @user.nil?
          render json: { error: 'User not found' }, status: :not_found
        end
      end
    end
  end
end
