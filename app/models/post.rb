class Post < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  has_many :likes, dependent: :destroy
  # validates :content, presence: { notice: '¡ Debe incluir un Cuac !' }
end
