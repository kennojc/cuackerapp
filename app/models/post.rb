class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  validates :content, presence: {message: "¡ Debe incluir un Cuac !"}
end
