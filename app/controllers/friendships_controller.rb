class FriendshipsController < ApplicationController
  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]).first
    @friendship.destroy
    respond_to do |format|
      format.html do
        flash[:danger] = "Friend was successfully removed"
        redirect_to my_friends_path
      end
    end
  end

end
