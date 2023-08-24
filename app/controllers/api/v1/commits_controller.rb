# frozen_string_literal: true

module Api
  module V1
    class CommitsController < ApplicationController
      before_action :set_user

      def index
        commits = @user.commits.includes(:blocks, :sticky_notes).order(id: :desc).limit(8)
        render json: commits, include: %i[blocks sticky_notes]
      end

      def create
        commit = @user.commits.new(commit_params)
        if commit.save
          render json: commit, status: :created, location: api_v1_user_commit_url(@user, commit), include: [:blocks]
        else
          render json: commit.errors, status: :unprocessable_entity
        end
      end

      def update
        commit = @user.commits.find(params[:id])
        if commit.update(commit_params)
          render json: commit, status: :ok, location: api_v1_user_commit_url(commit), include: [:blocks]
        else
          render json: commit.errors, status: :unprocessable_entity
        end
      end

      def destroy
        commit = @user.commits.find(params[:id])
        if commit.destroy
          render json: { status: 'SUCCESS', message: 'Commit deleted', data: commit }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Commit could not be deleted', data: commit.errors },
                 status: :unprocessable_entity
        end
      end

      private

      def commit_params
        params.require(:commit).permit(:id, :title, blocks_attributes: %i[id name length status])
      end

      def set_user
        @user = User.find_by(uid: params[:user_id])
        render json: { error: 'User not found' }, status: :not_found if @user.nil?
      end
    end
  end
end
