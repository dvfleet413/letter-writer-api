class Congregation < ApplicationRecord
    has_many :users
    has_many :territories
end
