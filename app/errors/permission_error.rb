# frozen_string_literal: true

class PermissionError < StandardError
  def initialize(msg = "User doesn't have permssion for this action")
    super(msg)
  end
end
