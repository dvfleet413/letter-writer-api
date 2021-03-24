class Congregation < ApplicationRecord
    has_many :users
    has_many :territories
    has_many :external_contacts
end
