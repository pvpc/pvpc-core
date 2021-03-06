class FriendshipInvitesController < ApplicationController
  has_scope :to_user_id

  def accept
    @model = FriendshipInvite.find(params[:id])
    authorize! :accept, @model
    @model.accept!
  end

  protected

  def create_params
    params.permit(:from_user_id, :to_user_id)
  end
end
