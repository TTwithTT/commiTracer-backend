module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.find_or_create_by(
          provider: params[:provider], 
          uid: params[:uid], 
          name: params[:name],
          email: params[:email]
        )
        if user
          head :ok
        else
          render json: { error: "Login failed."}, status: :unprocessable_entity
        end
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end

      def destroy
        user = User.find_by(uid: params[:uid])
        if user
          user.destroy
        else
          render json: { error: "The user not found."}, status: :not_found
        end
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end
    end
  end
end
