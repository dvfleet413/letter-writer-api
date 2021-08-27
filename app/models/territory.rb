class Territory < ApplicationRecord
    has_many :points
    has_many :dncs
    has_many :assignments
    belongs_to :congregation

    def polygon
        self.points.map {|point| [point["lat"], point["lng"]]}
    end
end
