# frozen_string_literal: true
class SwarmsController < ApplicationController
  def index
    @swarms = Swarm.all
  end

  def new
  end

  def show
    @swarm = Swarm.find(params[:id])
  end

  def create
    Swarm.create(swarm_params)
    flash[:notice] = t(:swarm_registered)
    redirect_to swarms_path
  end

  def destroy
    Swarm.delete(params[:id])
    flash[:notice] = t(:swarm_unregistered)
    redirect_to swarms_path
  end

  private

  def swarm_params
    params.require(:swarm).permit(:name, :swarm_nodes)
  end
end
