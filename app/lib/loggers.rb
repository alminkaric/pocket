# typed: false
# frozen_string_literal: true

# TODO: Add doc
module Loggers
  extend T::Sig

  private

  sig { params(message: String).void }
  def debug_logger(message)
    method_caller_name = caller_locations(1, 1)[0].label
    Rails.logger.debug "DEBUG [#{self.class}.#{method_caller_name}]: #{message}"
  end

  sig { params(message: String).void }
  def info_logger(message)
    method_caller_name = caller_locations(1, 1)[0].label
    Rails.logger.info "INFO [#{self.class}.#{method_caller_name}]: #{message}"
  end
end
