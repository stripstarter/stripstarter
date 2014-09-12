class UsersController < ApplicationController

  def index
    _rand = rand(Performer.count - 5)
    @performers = Performer.offset(_rand).first(5)
    respond_to do |format|
      format.html { render "performers/index" }
      format.json { render json: @performers, root: false }
    end
  end

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
      StripstarterMailer.delay.welcome_email(@user.id)
      redirect_to user_path(@user)
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
      :avatar,
      :email,
      :first_name,
      :last_name,
      :password,
      :password_confirmation,
      :type
    )
  end
end
