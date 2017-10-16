class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

    has_many :posts
    has_many :comments
    has_one :address

    validates :username, :presence => { :message => "must enter a username" }
    validates :email, :confirmation => { :message => "emails must match" }
    validates :username, :uniqueness => { :message => "username already in use" }

    scope :tomtest, -> { where(fname: 'Tom') }

end
