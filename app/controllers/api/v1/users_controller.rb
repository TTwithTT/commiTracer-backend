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
        user = User.find_by(email: params[:email])
        if user
          user.destroy
        else
          render json: { error: "The user not found."}, status: :not_found
        end
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end
      # def create
      #   # Find an existing user by the external provider's uid
      #   @user = User.find_by(uid: params[:uid], provider: params[:provider])
      
      #   # If the user doesn't exist, create a new one
      #   if @user.nil?
      #     @user = User.create(user_params)
      #   end
      
      #   # if the user is persisted correctly, send a success status, else send an error status
      #   if @user.persisted?
      #     render json: @user, status: :created
      #   else
      #     render json: @user.errors, status: :unprocessable_entity
      #   end
      # end
      
      # private
      
      # # Only allow a list of trusted parameters through.
      # def user_params
      #   params.permit(:uid, :provider, :name, :email)
      # end
    end
  end
end
