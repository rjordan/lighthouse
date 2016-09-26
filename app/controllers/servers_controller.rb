# frozen_string_literal: true
class ServersController < ApplicationController
  def index
    @servers = Server.all
  end

  def show
    @server = params[:id]
  end
end
