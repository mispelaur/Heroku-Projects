class GamesController < ApplicationController

  def index
  end

  def new
  # instantiate a new game row in table then redirect to /games/:id
    @game = Game.new
    redirect_to()
  end

  def show
  end

  def create
  end
end
