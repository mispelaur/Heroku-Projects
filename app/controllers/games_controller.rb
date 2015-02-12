class GamesController < ApplicationController

  def index
  end

  def new
  # instantiate a new game row in table then redirect to /games/:id
    @game = Game.new
    # @move = Move.new
  end

  def show
    game = Game.find(params[:id])
    coordinate_array = game.get_coordinates_array
    @board = Game.generate_board(coordinate_array)
    @move = Move.new
  end

  def create
    #blank game form w/submit button
    game = Game.create
    if game.save
      redirect_to game
    else
      redirect root
    end
  end


end
