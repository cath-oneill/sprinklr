class UsersController < ApplicationController
  before_action :set_user

  # GET /users/1
  # GET /users/1.json
  def show
    @yards = current_user.yards
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      unless @user.address.nil? || @user.zip.nil?
        GeocodeWorker.perform_async(@user.id, @user.address, @user.zip)
      end
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit, notice: 'Please fill out all required fields.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :address, :zip, :contact_method, :email, :phone)
    end
end
