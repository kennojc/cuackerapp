ActiveAdmin.register Friend do
  belongs_to :user
  
  #
   permit_params :friend_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:friend_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
