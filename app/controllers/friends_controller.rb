class FriendsController < ApplicationController
    
    def index
        @friends = Friend.all
            
    end
    
    def create 
        friend_id = params.require(:user_id)
        followed = User.find_by(id: friend_id)
        @friend = Friend.create(user_id: current_user.id, friend_id: followed.id)
        @friend.save
        redirect_to root_path
    end
end
