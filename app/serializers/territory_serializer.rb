class TerritorySerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :sorted_assignments,
             :contacts
  
  has_many :points
  has_many :dncs

  def sorted_assignments
    object.sorted_assignments
  end

  def contacts
    object.contacts
  end
             
end
