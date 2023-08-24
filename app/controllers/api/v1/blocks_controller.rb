# frozen_string_literal: true

module Api
  module V1
    class BlocksController < ApplicationController
      def destroy
        block = Block.find(params[:id])
        if block.destroy
          render json: { status: 'SUCCESS', message: 'Block deleted', data: block }, status: :ok
        else
          render json: { status: 'ERROR', message: block.errors.full_messages.to_sentence, data: block.errors },
                 status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { status: 'ERROR', message: 'Block not found' }, status: :not_found
      end

      private

      def block_params
        params.require(:block).permit(:id, :name, :length, :status)
      end
    end
  end
end
