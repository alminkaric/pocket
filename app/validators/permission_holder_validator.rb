# typed: ignore
# frozen_string_literal: true

class PermissionHolderValidator < ActiveModel::Validator
  extend T::Sig

  sig { params(permission: PermissionModelValidator).void }
  def validate(permission)
    permission.errors.add :holder, 'Permssion holder invalid' unless permission_holder_valid?(permission)
  end

  private

  sig { params(permission: PermissionModelValidator).returns(T::Boolean) }
  def permission_holder_valid?(permission)
    holder_class = T.cast(permission.holder_type.constantize, T.class_of(ApplicationRecord))
    return true if holder_class.find(permission.holder_id).present?

    false
  rescue NameError, ActiveRecord::RecordNotFound
    false
  end
end
