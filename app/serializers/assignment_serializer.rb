class AssignmentSerializer < ActiveModel::Serializer
  attributes :id,
             :publisher,
             :checked_out,
             :checked_in,
             :territory,
             :contacts
  
  def territory
    object.territory
  end

  def contacts
    if object.checked_in
      return []
    else
      return object.territory.congregation.api_access ? object.territory.contacts : object.territory.external_contacts
    end
  end
end
