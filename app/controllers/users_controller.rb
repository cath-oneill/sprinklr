class UsersController < ApplicationController
  before_action :set_user
  before_action :set_yard

  # GET /profile
  def show
    @recommendations = @yard.recommendations.order(created_at: :desc)
  end

  # GET /edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    need_to_update_user = @user.address != user_params['address'] || @user.zip != user_params['zip']
    if @user.update(user_params) && @yard.update(yard_params)
      @yard.calculate_sprinkler_flow
      GetWateringDay.run(@yard, @user)
      GeocodeWorker.perform_async(@user.id, @user.address, @user.zip) if need_to_update_user
      redirect_to "/profile", notice: 'User was successfully updated.'
    else
      render :edit, notice: 'Please fill out all required fields.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    def set_yard
      if current_user
        @yard = current_user.yard
      else
        @yard = Yard.new
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :address, :zip, :contact_method, :email, :phone, :yard)
    end
    def yard_params
      params.require(:yard).permit(:grass, :sprinkler, :sprinkler_flow_inches, :sprinkler_flow_minutes)
    end

end
