class ApiController < ActionController::Base
    # before_action :check_basic_auth
    skip_before_action :verify_authenticity_token
      
    def api
      @tweets = Post.all.order( created_at: :desc ).limit(50)
      api_array = Array.new
      @tweets.each do |t|
        apihash = {
          :id => t.id,
          :content => t.content,
          :user_id => t.user_id,
          :likes_count => t.likes.count,
          :retweets_count => t.id,
          :retweeted_from => t.post_id
        }
        api_array << apihash
      end
      render json: api_array
    end

    def interval
      start = params[:date1]
      finish = params[:date2]
      @tweets = Post.where(:created_at => start..finish).order(:desc)
      render json: @tweets
    end
end


