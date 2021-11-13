class Assignment < ApplicationRecord
  belongs_to :territory
  scope :in_progress, -> {where( checked_in: nil) }
  scope :completed, -> { where( "checked_in IS NOT NULL") }
end
