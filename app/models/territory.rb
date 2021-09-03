class Territory < ApplicationRecord
    has_many :points
    has_many :dncs
    has_many :assignments
    belongs_to :congregation

    def polygon
        self.points.map {|point| [point["lat"], point["lng"]]}
    end

    def data_axle_polygon
        self.points.map{|point| {lat: point.lat, lon: point.lng}}
    end

    def sorted_assignments
        self.assignments.order(:checked_out)
    end
end
