class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_as_admin, :except => [:my_account, :update_my_account]

  def index
    @users = User.where :role => 'customer'
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def my_account
    @user = current_user
  end

  def update_my_account
    @user = current_user
    params[:user]
    if @user.update_attributes(params[:user])
      redirect_to my_account_path, :notice => "Settings updated"
    else
      redirect_to my_account_path, :alert => "Unable to update settings: #{@user.errors.messages}"
    end
  end
  
  def update
    @user = User.find(params[:id])
    role = Role.find(params[:user][:role_ids]) unless params[:user][:role_ids].nil?
    params[:user] = params[:user].except(:role_ids)
    if @user.update_attributes(params[:user])
      @user.update_plan(role) unless role.nil?
      redirect_to users_path, :notice => "Customer updated."
    else
      redirect_to users_path, :alert => "Unable to update customer."
    end
  end

  def create
    @user = User.new params[:user]
    @user.password = Devise.friendly_token[0,20]
    @user.role = 'customer'

    if @user.save
      redirect_to users_path, :notice => "Customer created"
    else
      flash[:alert] = "Unable to create customer"
      render action: "new"
    end
  end
    
  def destroy
    user = User.find(params[:id])
    unless user == current_user
      if user.customer_id.nil?
        # not saved in stripe yet, just delete
        user.destroy
      else
        user.cancel_subscription
        user.destroy
      end
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end