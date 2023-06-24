module Api
  module V1
    class BlocksController < ApplicationController
      def destroy 
        block = Block.find(params[:id])
        if block.destroy
          render json: { status: 'SUCCESS', message: 'Block deleted', data: block }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Block could not be deleted', data: block.errors }, status: :unprocessable_entity
        end
      end

      private

      def block_params
        params.require(:block).permit(:id, :name, :length, :status)
      end
    end
  end
end
