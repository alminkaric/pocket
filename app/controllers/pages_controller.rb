# typed: true
# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!
  layout 'hr_admin_dashboard'

  def home; end
end
