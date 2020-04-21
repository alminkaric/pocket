# frozen_string_literal: true

class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at
end
