class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    # before_action :authenticate_user!

    # ======= GET /stoxx =======
    def stoxx
        puts "/n******* stoxx *******"

        # == data format: yyyymmdd[hhmm[ss]]
        startDate = "20170121" + "000000"
        endDate = "20170317" + "000000"
        symbol = "IBM"
        remote_key = Rails.application.config.bar_chart_key

        remote_url = "https://marketdata.websol.barchart.com"
        remote_url += "/getHistory.json?key=" + remote_key + "&symbol=" + symbol
        remote_url += "&type=daily&startDate=" + startDate + "&endDate=" + endDate

        json_data = HTTParty.get(remote_url)
        puts " ** json_data['results'].length: #{json_data['results'].length.inspect}"
        @stock_data = json_data['results']

    end

    # ======= GET /users =======
    def home
        puts "/n******* home *******"
        puts " ** current_user: #{current_user.inspect}"
        puts " ** User.column_names: #{User.column_names.inspect}"

        @users = User.all
        @posts_array = []
        @post_tags_array = []

        @users.each do |user|
            posts = user.posts

            # == user has at least one post
            if posts.length > 0
                @posts_array << posts[0]
                @post_tags = posts[0].tags

                # == get assigned/not assigned tags
                if @post_tags.length > 0
                    @post_tag_ids = @post_tags.map{|pt| pt.id }
                    @post_no_tags = Tag.where("id NOT IN (?)", @post_tag_ids)
                else
                    @post_no_tags = Tag.all
                end
                @post_tags_array << [@post_tags, @post_no_tags]

            # == no posts (create placeholders)
            else
                @posts_array << "no_post"
                @post_tags_array << [[], []]
            end
        end
    end

    # ======= GET /add_new_tag =======
    def add_new_tag
        puts "******* add_new_tag *******"
        puts " ** params: #{params.inspect}"

        @post_id = params[:post_id]

        # == create brand new tag; add to Tags
        if params[:new_tag] != "new"

            # == check if tag already exists
            check_tag = Tag.where(tag_name: params[:new_tag])
            puts " ** check_tag.length: #{check_tag.length.inspect}"

            # == create new tag if not existing and assign to post
            if check_tag.length == 0
                @tag = Tag.create(tag_name: params[:new_tag], tag_rank: 0)
                @post_tag = PostTag.create(post_id: params[:post_id], tag_id: @tag[:id])
                puts " ** NEW TAG @post_tag: #{@post_tag.inspect}"
            end
        end

        # == assign existing tag if selected from select box (not "ng")
        if params[:tag_id] != "ng"

            # == check if tag already assigned to post
            check_tag = PostTag.where(post_id: params[:post_id], tag_id: params[:tag_id])
            puts " ** check_tag.length: #{check_tag.length.inspect}"

            if check_tag.length == 0
                @post_tag = PostTag.create(post_id: params[:post_id], tag_id: params[:tag_id])
                puts " ** EXISTING TAG @post_tag: #{@post_tag.inspect}"
            end
        end
        @post_tags = PostTag.where(post_id: params[:post_id])
        @post_tag_ids = @post_tags.map{|pt| pt.tag_id }
        @post_no_tags = Tag.where("id NOT IN (?)", @post_tag_ids)
        @tags = Tag.where(id: @post_tag_ids)
        render json: { tags: @tags, post_no_tags: @post_no_tags, post_id: @post_id}
    end

    # ======= GET /toggle_tag =======
    def toggle_tags
        puts "\n\n******* toggle_tags *******"

        # == get post_id and tag_id from combined :ids string (e.g. 1_4)
        ids = params[:ids].split("_")
        @post_id = ids[0]
        tag_id = ids[1]

        # == check post for selected tag
        @post_tag = PostTag.where(post_id: @post_id, tag_id: tag_id).first

        # == remove previously assigned tag
        if @post_tag
            puts "******* HAS TAG (delete tag) *******"
            @post_tag.destroy

            @post_tags = PostTag.where(post_id: @post_id)
            @post_tag_ids = @post_tags.map{|pt| pt.tag_id }
            @post_no_tags = Tag.where("id NOT IN (?)", @post_tag_ids)
            @tags = Tag.where(id: @post_tag_ids)
            render json: { tags: @tags, post_no_tags: @post_no_tags, post_id: @post_id}
        end
    end

    # ======= GET /toggle_state =======
    def toggle_state
        puts "******* toggle_state *******"
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
    #   puts " ** self.latlon: #{self.latlon.inspect}"
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

        def toggle_params
          puts "******* toggle_params *******"
          params.permit(:post_id, :tag_id, :new_tag, :ids)
        end

        def user_params
          puts "******* user_params *******"
          params.require(:user).permit(:fname, :lname, :email, :email_confirmation, :username, :password)
        end
end
