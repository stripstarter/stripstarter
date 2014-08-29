class UsersController < ApplicationController

  def show
    @user = current_user
    respond_to do |format|
      format.json { render json: @user }
      format.html
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Registration successful."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated profile."
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end

  private

  def user_params
    (params["user"] || params["pledger"] || params["performer"]).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :role
    )
  end
end
