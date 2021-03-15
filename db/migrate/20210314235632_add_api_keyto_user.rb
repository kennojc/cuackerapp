class AddApiKeytoUser < ActiveRecord::Migration[6.1]
  
  def change
    add_column :users, :api_key, :string
     User.find_each do |u|
      api_key = u.generate_api_key
      u.update_columns(api_key: api_key)

     end
     change_column :users, :api_key, :string, unique: true, null: false
     add_index :users, :api_key, unique: true
  end
end
