class Photo < ApplicationRecord

    puts " ** ENV['S3_BUCKET']: #{ENV['S3_BUCKET'].inspect}"
    puts " ** ENV['S3_REGION']: #{ENV['S3_REGION'].inspect}"
    puts " ** ENV['AWS_ACCESS_KEY_ID']: #{ENV['AWS_ACCESS_KEY_ID'].inspect}"
    puts " ** ENV['AWS_SECRET_ACCESS_KEY']: #{ENV['AWS_SECRET_ACCESS_KEY'].inspect}"

    has_attached_file :image,
        styles: {
            large: "500x500#",
            medium: "300x300#",
            thumb: "100x100#"
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
        },
        default_url: "/images/:style/missing_image.jpg"
    validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

end
