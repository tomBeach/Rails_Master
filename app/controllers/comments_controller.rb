class CommentsController < ApplicationController
    before_action :set_comments
    before_action :set_comment, only: [:show, :edit, :update, :destroy]

    # GET posts/1/comments
    def index
        @comments = @post.comments
    end

    # GET posts/1/comments/1
    def show
        puts "******* show *******"
        @comments = @comment.comments
        puts " ** @comments.inspect: #{@comments.inspect}"
    end

    # GET posts/1/comments/new
    def new
        @comment = @post.comments.build
    end

    # GET posts/1/comments/1/edit
    def edit
        puts "******* edit *******"
        puts " ** params.inspect: #{params.inspect}"
        @comment = Comment.find(params[:id])
        puts " ** @comment.inspect: #{@comment.inspect}"
    end

    # POST posts/1/comments
    def create
        @comment = @post.comments.build(post_params)

        if @comment.save
            redirect_to([@comment.post, @comment], notice: 'Comment was successfully created.')
        else
            render action: 'new'
        end
    end

    # PUT posts/1/comments/1
    def update
        puts "******* update *******"
        puts "** params.inspect: #{params.inspect}"
        if @comment.update_attributes(post_params)
            post = Post.find(post_params[:post_id])
            puts "** post.inspect: #{post.inspect}"
            post_user = User.find(post[:user_id])
            puts "** post_user.inspect: #{post_user.inspect}"
            redirect_to(user_posts_path(post_user[:id]), notice: 'Comment was successfully updated.')
        else
            render action: 'edit'
        end
    end

  # DELETE posts/1/comments/1
  def destroy
    @comment.destroy

    redirect_to post_comments_url(@post)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comments
        puts "******* set_comments *******"
        puts "** params.inspect: #{params.inspect}"
        # @comment = @post.comments.find(params[:id])
    end

    def set_comment
        puts "******* set_comment *******"
        puts "** params.inspect: #{params.inspect}"
        @comment = Comment.find(params[:id])
        puts "** @comment.inspect: #{@comment.inspect}"
        # @comment2 = @post.comments.find(params[:id])
        # puts "** @comment2.inspect: #{@comment2.inspect}"
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
        puts "******* post_params *******"
        puts "** params.inspect: #{params.inspect}"
        # @post = @user.posts.find(params[:id])
        params.require(:comment).permit(:user_id, :post_id, :content)
    end
end
