class Address < ApplicationRecord
    belongs_to :user
    validates :street, :city, :state, :zip, presence: true
    validates :zip, length: 5
    validates :zip, numericality: true
    validates :email, confirmation: true
end
