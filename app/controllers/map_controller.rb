class MapController < ApplicationController
before_filter :disable_nav

  def map
    @date = Date.today - 1
    render 'map'
  end

end