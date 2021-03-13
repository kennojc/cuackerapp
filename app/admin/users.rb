ActiveAdmin.register User do
  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :username, :photolink
 
  
  index do
    selectable_column
    column "Usuario", :username
    actions dropdown: true
    column :posts do |user|
      user.posts.count
    end
    column :likes do |user|
      user.likes.count
    end
    column "Seguidos", :friends do |user|
      user.friends.count
    end
  end
  
end
