class MovesController < ApplicationController
  
  def index
  end

  def new
  #creates new row in Move table via link on games/:id view page w/ game_id and coordinates, redirect to games/:id (games/:game_id)
    @move = Move.new
    game_id = params[:id]
    @move.game_id = game_id
  end

  def create
    move = Move.create(move_params)
    move.user = current_user
    if move.save
      redirect_to game_path(move.game_id)
    else
      render 'new'
    end
  end

  private
  def move_params
    params.require(:move).permit(:move_coordinate, :game_id, :user_id)
  end
end
