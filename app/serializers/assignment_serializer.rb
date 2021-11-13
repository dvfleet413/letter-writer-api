class AssignmentSerializer < ActiveModel::Serializer
  attributes :id,
             :publisher,
             :checked_out,
             :checked_in,
             :territory
  
  def territory
    object.territory
  end
end
