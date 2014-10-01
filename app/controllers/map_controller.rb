class MapController < ApplicationController
before_filter :disable_nav

  def map
    render 'map'
  end
end