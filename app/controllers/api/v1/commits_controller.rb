module Api
  module V1
    class CommitsController < ApplicationController
      def create
        @commit = Commit.new(commit_params)
        if @commit.save
          render json: @commit, status: :created, location: api_v1_commit_url(@commit), include: [:blocks]
        else
          render json: @commit.errors, status: :unprocessable_entity
        end
      end

      private

      def commit_params
        params.require(:commit).permit(:title, :scheduledDate, blocks_attributes: [:index, :name, :length])
      end
    end
  end
end
