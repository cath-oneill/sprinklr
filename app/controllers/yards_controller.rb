class YardsController < ApplicationController
  before_action :set_yard


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_yard
      @yard = Yard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def yard_params
      params.require(:yard).permit(:grass, :name, :slope, :soil, :sprinkler)
    end
end
