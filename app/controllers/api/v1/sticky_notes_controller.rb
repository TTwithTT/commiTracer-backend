module Api
  module V1
    class StickyNotesController < ApplicationController
      before_action :set_user, :set_commit
      
      def create
        sticky_note = @commit.sticky_notes.new(sticky_note_params)
        
        if sticky_note.save
          render json: { status: 'SUCCESS', message: 'Sticky Note created', data: sticky_note }, status: :created
        else
          render json: { status: 'ERROR', message: 'Sticky Note could not be created', data: sticky_note.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        sticky_note = @commit.sticky_notes.find(params[:id])
        
        if sticky_note.destroy
          render json: { status: 'SUCCESS', message: 'Sticky Note deleted', data: sticky_note }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Sticky Note could not be deleted', data: sticky_note.errors }, status: :unprocessable_entity
        end
      end

      private

      def sticky_note_params
        params.require(:sticky_note).permit(:id :reflection)
      end

      def set_user
        @user = User.find(uid: params[:user_id])
        render json: { error: 'User not found' }, status: :not_found if @user.nil?
      end
      
      def set_commit
        @commit = @user.commits.find(params[:commit_id])
        render json: { error: 'Commit not found' }, status: :not_found if @commit.nil?
      end
    end
  end
end
