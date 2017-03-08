class PostsController < ApplicationController
    before_action :set_posts
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    # GET users/1/posts
    def index
        puts "******* posts:index *******"
        puts " ** @user.inspect: #{@user.inspect}"
        @posts = @user.posts
    end

    # GET users/1/posts/1
    def show
        puts "******* posts:show *******"
        @comments = @post.comments
        puts " ** @post.inspect: #{@post.inspect}"
        puts " ** @comments.inspect: #{@comments.inspect}"
    end

    # GET users/1/posts/new
    def new
        puts "******* posts:new *******"
        puts " ** params.inspect: #{params.inspect}"
        @post = @user.posts.build
        puts " ** @post.inspect: #{@post.inspect}"
        @post2 = Post.new
        puts " ** @post2.inspect: #{@post2.inspect}"
    end

    # GET users/1/posts/1/edit
    def edit
    end

    # POST users/1/posts
    def create
        @post = @user.posts.build(post_params)

        if @post.save
            redirect_to(user_posts_path(@user, @posts), notice: 'Post was successfully created.')
        else
            render action: 'new'
        end
    end

    # PUT users/1/posts/1
    def update
        if @post.update_attributes(post_params)
            redirect_to(user_posts_path(@user, @posts), notice: 'Post was successfully updated.')
        else
            render action: 'edit'
        end
    end

    # DELETE users/1/posts/1
    def destroy
        @post.destroy

        redirect_to user_posts_url(@user)
    end

    private
        def set_posts
            @user = User.find(params[:user_id])
        end

        def set_post
            @post = @user.posts.find(params[:id])
        end

        def post_params
            params.require(:post).permit(:user_id, :title, :content)
        end
end
