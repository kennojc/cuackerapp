ActiveAdmin.register Like do
  belongs_to :post
  belongs_to :user
  permit_params :post_id, :user_id

  
end
