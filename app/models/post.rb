class Post < ApplicationRecord
  scope :tweets_for_me, ->(friend_list, current_user_id) { where(:user_id => (friend_list).push(current_user_id)) }
  
  belongs_to :user
  belongs_to :post, optional: true
  has_many :likes, dependent: :destroy
  # validates :content, presence: { notice: '¡ Debe incluir un Cuack !' }

  def post_class
    if post_id?
      "retweet"
    else
      "simple"
    end
  end

  def username
    user.username
  end


end
