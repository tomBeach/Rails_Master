class Photo < ApplicationRecord

    puts " ** ENV['S3_BUCKET']: #{ENV['S3_BUCKET'].inspect}"
    # if Rails.env.development?
    #   S3_BUCKET: ENV["S3_BUCKET"]
    # elsif Rails.env.test?
    #   S3_BUCKET: ENV["S3_BUCKET_TEST"]
    # elsif Rails.env.production?
    #   S3_BUCKET: ENV["S3_BUCKET_PROD"]
    # end
    # puts " ** S3_BUCKET: #{S3_BUCKET.inspect}"

    has_attached_file :image,
                    styles: {
                        thumb: ["64x64#", :jpg],
                        original: ['500x500>', :jpg]
                    },
                    convert_options: {
                        thumb: "-quality 75 -strip",
                        original: "-quality 85 -strip"
                    },
                    storage: :s3,
                    s3_region: ENV["S3_REGION"],
                    s3_credentials: {
                        bucket: ENV["S3_BUCKET"],
                        access_key_id: ENV["AWS_ACCESS_KEY_ID"],
                        secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
                    }
    validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

end
