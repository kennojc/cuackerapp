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
          :retweeted_from => t.post_id.nil? ? 'No hay retweet' : t.retweeter
        }
        api_array << apihash
      end
      render json: api_array
    end

    def interval
      start = params[:date1].to_date
      finish = params[:date2].to_date.end_of_day
      @tweets = Post.where(:created_at => start..finish).order(:desc)
      render json: @tweets
    end

    def api_post
      
      @user = User.find_by(email:request.headers["X-EMAIL"]) 

      if @user.present?
        @post = Post.new(user: @user, content:request.headers["X-CUAC"])
          if request.headers["X-API-KEY"] == @user.api_key
            
            if @post.save
              render json: @post
            else
              render json: "Cuack no salvado."
            end
            
          else
            render json: "API KEY no es válida."
          end
      else
        render json: "Usuario no encontrado."
      end


    end
  
  
  
  end


