class WelcomeController < ApplicationController
  before_filter :disable_nav
  before_filter :welcome_only

  def index
  end
end
