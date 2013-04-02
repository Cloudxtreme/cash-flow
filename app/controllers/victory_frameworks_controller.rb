class VictoryFrameworksController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def destroy
    @victory_framework = VictoryFramework.find params[:id]
    @victory_framework.destroy
    redirect_to dashboard_url, :notice => 'Victory Framework deleted'
  end

  def new
    @victory_framework = VictoryFramework.new
  end

  def edit
    @victory_framework = VictoryFramework.find params[:id]
  end

  def create
    @victory_framework = VictoryFramework.new params[:victory_framework]

    if @victory_framework.save
      redirect_to dashboard_url, :notice => 'Victory Framework version created'
    else
      render 'new'
    end
  end

  def update
    @victory_framework = VictoryFramework.find params[:id]

    if @victory_framework.update_attributes params[:victory_framework]
      redirect_to dashboard_url, :notice => 'Victory Framework updated'
    else
      redirect_to dashboard_url, :notice => 'Unable to update Victory Framework'
    end

  end
end