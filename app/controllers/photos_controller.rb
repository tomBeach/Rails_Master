class PhotosController < ApplicationController
    before_action :set_user
    before_action :set_photo, only: [:show, :edit, :update, :destroy]
    before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]

    def index
        puts"\n******* index *******"
        @photos = Photo.order(created_at: :desc)
    end

    def show
        puts"\n******* show *******"
    end

    def edit
        puts"\n******* edit *******"
        @new_flag = false
    end

    def update
        puts"\n******* update *******"
        if @photo.update(photo_params)
            redirect_to user_photos_path(current_user), notice: 'Photo was successfully updated.'
        else
            render :edit
        end
    end

    def new
        puts"\n******* new *******"
        @new_flag = true
        @photo = Photo.new(user_id: current_user.id)
        puts"** @photo: #{@photo.inspect}"
    end

    def create
        puts"\n******* create *******"
        @photo = Photo.new(photo_params)
        if @photo.save
            redirect_to user_photos_path(current_user), notice: "The photo was added!"
        else
            flash[:notice] = "Photo was not added... try again"
            render 'new'
        end
    end

    def destroy
        puts"\n******* destroy *******"
        puts"** params: #{params.inspect}"
        @photo.destroy
        redirect_to user_photos_path(current_user), notice: 'Photo was successfully removed.'
    end

    private
        # user_id, title, caption, content_type, date_taken
        def set_s3_direct_post
            puts "\n******* set_s3_direct_post *******"
            @s3_direct_post = S3_BUCKET.presigned_post(
                key: "uploads/#{SecureRandom.uuid}/${filename}",
                success_action_status: '201',
                acl: 'public-read'
            )
            puts"** @s3_direct_post: #{@s3_direct_post.inspect}"
        end
        def set_user
            puts "\n******* set_user *******"
            if current_user
                @user = current_user
            end
        end
        def set_photo
            puts "\n******* set_photo *******"
            @photo = Photo.find(params[:id])
        end
        def photo_params
            puts"\n******* photo_params *******"
            params.require(:photo).permit(:image, :user_id, :title, :caption, :content_type, :date_taken)
        end
end
