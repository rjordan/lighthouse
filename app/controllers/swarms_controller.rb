# frozen_string_literal: true
class SwarmsController < ApplicationController
  def index
  end

  def new
  end

  def create
    Swarm.create(swarm_params)
    flash[:notice] = t(:swarm_registered)
    redirect_to swarms_path
  end

  private

  def swarm_params
    params.require(:swarm).permit(:swarm_nodes)
  end
end
