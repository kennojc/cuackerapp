class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy retweet]

  # GET /posts or /posts.json
  def index
    @q = Post.ransack(params[:q])
    if user_signed_in?
      followed = current_user.friends.pluck(:friend_id)
      @posts = @q.result(distinct: true).tweets_for_me(followed, current_user.id).order( created_at: :desc ).page params[:page]  

    else
      @posts = @q.result(distinct: true).order( created_at: :desc ).page params[:page]
    end
    
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
      @post = current_user.posts.new(post_params)
    

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: "Quack posteado" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to root_path, notice: "Debe ingresar primero.", status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Quack actualizado" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def user
    
    @user = User.find(params[:user_id])
    @posts = Post.where( user: @user ).order( created_at: :desc )
    @likes = @user.likes.joins( :post ).order( "posts.created_at DESC" )
  end

  

  def retweet
    recuac = current_user.posts.new(post_id: @post.id)
    if recuac.save
      redirect_to root_path, notice: "Recuack Exitoso"
    else
      redirect_to root_path, notice: "No se pudo realizar Recuack"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :content, :post_id)
    end
end
