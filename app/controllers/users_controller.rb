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
        # puts " ** json_data['results']: #{json_data['results'].inspect}"
        puts " ** json_data['results'].length: #{json_data['results'].length.inspect}"
        @stock_data = json_data['results']
        # puts " ** json_data: #{json_data.inspect}"
        # puts " ** json_data['status']: #{json_data['status'].inspect}"

        # data = JSON.parse(json_data)
        # puts " ** data['status']: #{data['status'].inspect}"


        # residents = data['Resident'].map { |rd| Resident.new(rd['phone'], rd['addr']) }


        # body = JSON.parse(response.body)
        # puts " ** body: #{body.inspect}"
        # puts " ** response.message: #{response.message.inspect}"
        # puts " ** response.headers: #{response.headers.inspect}"
        # puts " ** response.body: #{response.body.inspect}"

        # puts " ** @response: #{@response.inspect}"
        # puts " ** @response.length: #{@response.length.inspect}"

        # res = HTTP.get(remote_url).to_s
        # stock_data = res.results
        # puts " ** stock_data: #{stock_data.inspect}"

    end

    # ======= GET /users =======
    def home
        puts "/n******* home *******"
        puts " ** current_user: #{current_user.inspect}"

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
        puts " ** params.inspect: #{params.inspect}"

        # == create brand new tag; add to Tags
        if params[:new_tag] != "ng"
            check_tag = Tag.where(tag_name: params[:new_tag])
            puts " ** check_tag.inspect: #{check_tag.inspect}"
            if check_tag.length == 0
                @tag = Tag.create(tag_name: params[:new_tag], tag_rank: 0)
            end
            @post_tag = PostTag.create(post_id: params[:post_id], tag_id: @tag[:id])
            puts " ** @post_tag.inspect: #{@post_tag.inspect}"
        end

        # == assign existing tag
        if params[:tag_id] != ""
            @post_tag = PostTag.create(post_id: params[:post_id], tag_id: params[:tag_id])
            puts " ** @post_tag.inspect: #{@post_tag.inspect}"
        end
        render json: { "new_tag": params[:new_tag], "add_tag": params[:add_tag] }
    end

    # ======= GET /toggle_tag =======
    def toggle_tag
        puts "******* toggle_tag *******"
        puts " ** params.inspect: #{params.inspect}"
        @post_tag = PostTag.where(post_id: params[:post_id], tag_id: params[:tag_id]).first
        if @post_tag
            puts "******* HAS TAG (delete tag) *******"
            puts " ** @post_tag: #{@post_tag.inspect}"
            puts " ** @post_tag.id: #{@post_tag.id.inspect}"
            PostTag.destroy(@post_tag.id.to_i)
            render json: { "tag": false, "post_id": params[:post_id], "tag_id": params[:tag_id] }
        else
            puts "******* NO TAG (make new) *******"
            render json: { "tag": true, "post_id": params[:post_id], "tag_id": params[:tag_id] }
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
