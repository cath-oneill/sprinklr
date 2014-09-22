class WelcomeController < ApplicationController
  before_filter :disable_nav
  before_filter :disable_warnings

  def index
  end
end
