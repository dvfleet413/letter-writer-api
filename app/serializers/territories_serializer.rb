class TerritoriesSerializer < ActiveModel::Serializer
  attributes :id,
             :name
  
  has_many :assignments
end
