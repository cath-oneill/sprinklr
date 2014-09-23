class YardsController < ApplicationController
  before_action :set_yard, only: [:edit, :update, :destroy]


  # GET /yards/new
  def new
    @yard = Yard.new
  end

  # GET /yards/1/edit
  def edit
  end

  # POST /yards
  # POST /yards.json
  def create
    @yard = Yard.new(yard_params)
    @yard.user_id = current_user.id
    @yard.day = GetWateringDay.run(@yard, current_user)
    if @yard.save
      redirect_to current_user, notice: 'Yard was successfully created.' 
    else
      render :new 
    end
  end

  # PATCH/PUT /yards/1
  # PATCH/PUT /yards/1.json
  def update
    @yard.day = GetWateringDay.run(@yard, current_user)
    if @yard.update(yard_params)
      redirect_to @current_user, notice: 'Yard was successfully updated.' 
    else
      render :edit 
    end
  end

  # DELETE /yards/1
  # DELETE /yards/1.json
  def destroy
    @yard.destroy
    redirect_to yards_url, notice: 'Yard was successfully destroyed.' 
  end

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
