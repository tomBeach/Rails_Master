class User < ApplicationRecord
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

    has_many :posts
    has_many :comments

    validates :username, presence: true
    validates :email, confirmation: true
    validates :email, uniqueness: true

    scope :tomtest, -> { where(fname: 'Tom') }

end
