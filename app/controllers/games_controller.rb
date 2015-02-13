class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def show
    game = Game.find(params[:id])
    coordinate_array = game.get_coordinates_array
    @board = Game.generate_board(coordinate_array)
    @computer_move = Game.computer_move(@board)
    @move = Move.new
    @computer_turn = Game.computer_turn(game)
    @board_full = Game.board_full(@board)
    @game_won_by = Game.game_won_by(@board)
    if @game_won_by==-1
      current_user.wins += 1
      current_user.save
    end
    @status = Game.status(@board_full, @game_won_by)
  end

  def create
    game = Game.create
    if game.save
      redirect_to game
    else
      redirect root
    end
  end

end
