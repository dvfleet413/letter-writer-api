class TerritorySerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :contacts
  
  has_many :points
  has_many :dncs
  has_many :assignments

  def contacts
    object.contacts
  end
             
end
