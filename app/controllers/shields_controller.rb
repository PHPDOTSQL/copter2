class ShieldsController < ApplicationController
  def index
    @shields = Item::Shield.search(:c => params[:c], :d => params[:d], :page => params[:page])
  end

  def show
    @shield = Item::Shield.find(params[:id])
  end
end