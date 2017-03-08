class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    # before_action :authenticate_user!
    # after_validation :geocode_address

    # ======= GET /users =======
    def home
        puts "/n******* home *******"
        puts " ** current_user.inspect: #{current_user.inspect}"
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
    end

    # ======= GET /index =======
    def index
      puts "******* index *******"
      # @user = User.new
      @users = User.all
    end

    # ======= ======= ======= CRUD ======= =======  =======
    # ======= ======= ======= CRUD ======= =======  =======
    # ======= ======= ======= CRUD ======= =======  =======

    # GET /users/1
    # GET /users/1.json
    def show
        puts "******* show *******"
    end

    # GET /users/new
    def new
        puts "******* new *******"
        @user = User.new
    end

    # GET /users/1/edit
    def edit
        puts "******* edit *******"
    end

    # POST /users
    # POST /users.json
    def create
        puts "******* create *******"
        @user = User.new(user_params)

        respond_to do |format|
            if @user.save
                format.html { redirect_to @user, notice: 'User was successfully created.' }
            else
                format.html { render :new }
            end
        end
    end

    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
        puts "******* update *******"
        respond_to do |format|
            if @user.update(user_params)
                format.html { redirect_to @user, notice: 'User was successfully updated.' }
            else
                format.html { render :edit }
            end
        end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
        puts "******* destroy *******"
        @user.destroy
        respond_to do |format|
            format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        end
    end

    # ======= ======= ======= UTILITIES ======= =======  =======
    # ======= ======= ======= UTILITIES ======= =======  =======
    # ======= ======= ======= UTILITIES ======= =======  =======

    # ======= GET /user =======
    # def signin
    #   puts "******* signin *******"
    #   @user = User.where(username: signin_params[:username]).first
    #   puts "******* USER OK *******"
    #   if @user && User.where(password: signin_params[:password]).first
    #       puts "\n******* PSWD OK *******"
    #       session[:user_id] = @user.id
    #       redirect_to "/home", :flash => { :success => "Welcome!" }
    #   else
    #       redirect_to "/"
    #   end
    # end
    #
    # # ======= POST /signup =======
    # def signup
    #     puts "\n******* signup *******"
    #     @user = User.new(user_params)
    #     redirect_to :home
    # end
    #
    # # ======= GET /signout =======
    # def signout
    #     puts "******* signout *******"
    #     session[:user_id] = nil
    #     redirect_to :home
    # end

    # ======= geocode_address =======
    # def geocode_address
    #   self.latlon = Geocoder.new(request.ip)
    #   puts " ** self.latlon.inspect: #{self.latlon.inspect}"
    # end

    private
        # Use callbacks to share common setup or constraints between actions.
        def signin_params
          puts "\n******* signin_params *******"
          params.permit(:username, :password)
        end

        def set_user
          puts "******* set_user *******"
          @user = User.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def user_params
          puts "******* user_params *******"
          params.require(:user).permit(:fname, :lname, :email, :email_confirmation, :username, :password)
        end
end
