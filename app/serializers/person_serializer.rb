class PersonSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :created_at
end
