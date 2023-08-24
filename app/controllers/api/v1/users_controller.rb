# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.find_or_create_by(
          provider: params[:provider],
          uid: params[:userId],
          name: params[:name],
          email: params[:email]
        )
        if user
          render json: { data: user }
        else
          render json: { error: 'Login failed.' }, status: :unprocessable_entity
        end
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end

      def exist
        user = User.find_by(uid: params[:id])
        render json: { exists: user.present? }
      end

      def destroy
        user = User.find_by(uid: params[:id])
        if user
          user.destroy
          render json: { status: 'SUCCESS', message: 'User deleted', data: user }
        else
          render json: { error: 'The user not found.' }, status: :not_found
        end
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end
    end
  end
end
