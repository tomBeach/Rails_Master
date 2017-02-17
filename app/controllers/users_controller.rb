class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

    # ======= GET /home =======
    def home
        puts "******* home *******"
        # @user = User.new
        @users = User.all
        @bc = User.find(1)
        puts " ** @bc: #{@bc}"
        puts " ** @bc.posts: #{@bc.posts}"
        puts " ** @bc.comments: #{@bc.comments}"
        puts " ** @bc.comments.find(9): #{@bc.comments.find(9)}"
        puts " ** @bc.comments.where(post_id: 4): #{@bc.comments.where(post_id: 4)}"
        puts " ** @bc.posts.exists?(id: 5): #{@bc.posts.exists?(id: 5)}"
        puts " ** @bc.posts.exists?(id: 50): #{@bc.posts.exists?(id: 50)}"
        puts " ** @bc.posts.exists?(title: 'First Post'): #{@bc.posts.exists?(title: 'First Post')}"
        puts " ** @bc.posts.exists?(title: 'Third Post'): #{@bc.posts.exists?(title: 'Third Post')}"
    end

    # ======= GET /user =======
    def signin
        puts "******* signin *******"
        @user = User.where(username: signin_params[:username]).first
        puts "******* USER OK *******"
        if @user && User.where(password: signin_params[:password]).first
            puts "\n******* PSWD OK *******"
            session[:user_id] = @user.id
            redirect_to users_path, :flash => { :success => "Welcome!" }
        else
            redirect_to "/"
        end
    end

    # ======= POST /signup =======
    def signup
        puts "\n******* signup *******"
        @user = User.new(user_params)
        redirect_to :home
    end

    # ======= GET /signout =======
    def signout
        puts "******* signout *******"
        session[:user_id] = nil
        redirect_to :home
    end

    # ======= GET /users =======
    def index
        puts "******* index *******"
        @postsArray = []
        @users = User.all
        @users.each do |user|
            posts = user.posts
            if posts.length > 0
                @postsArray << posts
            else
                @postsArray << "no_post"
            end
        end
        puts " ** @postsArray.inspect: #{@postsArray.inspect}"
    end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
      # Use callbacks to share common setup or constraints between actions.
      def signin_params
          puts "\n******* signin_params *******"
          params.permit(:username, :password)
      end

      def set_user
          puts "******* index *******"
          @user = User.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def user_params
          puts "******* index *******"
          params.require(:user).permit(:fname, :lname, :email, :username, :password)
      end
end
