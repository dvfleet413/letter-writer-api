class Territory < ApplicationRecord
    has_many :points
    has_many :dncs
end
