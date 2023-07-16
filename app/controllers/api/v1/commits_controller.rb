module Api
  module V1
    class CommitsController < ApplicationController
      def index
        @commits = Commit.order(id: :desc).limit(5)
        render json: @commits, include: [:blocks]
      end

      def create
        @commit = Commit.new(commit_params)
        if @commit.save
          render json: @commit, status: :created, location: api_v1_commit_url(@commit), include: [:blocks]
        else
          render json: @commit.errors, status: :unprocessable_entity
        end
      end

      def update
        @commit = Commit.find(params[:id])
        if @commit.update(commit_params)
          render json: @commit, status: :ok, location: api_v1_commit_url(@commit), include: [:blocks]
        else
          render json: @commit.errors, status: :unprocessable_entity
        end
      end

      private

      def commit_params
        params.require(:commit).permit(:id, :title, :scheduledDate, blocks_attributes: [:id, :name, :length, :status])
      end
    end
  end
end
