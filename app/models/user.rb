class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_create :set_api_key
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friends, dependent: :destroy

  def generate_api_key
    SecureRandom.base58(24)
  end

  def set_api_key
    self.api_key = generate_api_key
  end


  
end
