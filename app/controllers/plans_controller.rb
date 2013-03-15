class PlansController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_as_admin

  def index
    @plans = Plan.all
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def create
    @plan = Plan.new params[:plan]
    if @plan.save_with_stripe
      redirect_to plans_path, :notice => "Plan created"
    else
      flash[:alert] = "Unable to create plan"
      render action: "new"
    end
  end

  def new
    @plan = Plan.new
  end

  def destroy
    @plan = Plan.find(params[:id])
    if @plan.destroy_with_stripe
      redirect_to plans_path, :notice => 'Plan deleted'
    else
      render action: "edit"
    end
  end

  def update
    @plan = Plan.find(params[:id])

    if @plan.update_with_stripe params[:plan]
      redirect_to plans_path, :notice => "Plan updated"
    else
      render action: "edit"
    end
  end

end