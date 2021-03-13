ActiveAdmin.register Post do
  belongs_to :user
  belongs_to :post
  permit_params :user_id, :content, :post_id
  
end
