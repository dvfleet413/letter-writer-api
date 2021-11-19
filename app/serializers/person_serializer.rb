class PersonSerializer < ActiveModel::Serializer
  attributes :id
             :name
             :email
             :role
             :account_access
end
