# typed: strict
# frozen_string_literal: true

##
# Serializer for Person
#
class PersonSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :client_id, :created_at
end
