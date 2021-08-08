class Congregation < ApplicationRecord
    has_many :users
    has_many :territories
    has_many :external_contacts
    has_many :cong_points
end
