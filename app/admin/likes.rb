ActiveAdmin.register Like do
  belongs_to :post
  belongs_to :user
  permit_params :post_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:post_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
