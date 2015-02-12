class Game < ActiveRecord::Base
  has_many :moves

  def get_coordinates_array
    coordinates_array = Array.new
    self.moves.each do |move|
      coordinates_array << move.move_coordinate
    end
    coordinates_array
  end  

  def self.generate_board(coordinates_array)
    @board = Array.new(9, 0)
    move_number = 0
    
    #can be refactored yeh!
    unless coordinates_array.empty?
      while move_number < coordinates_array.length
        # binding.pry
        coordinates_array.each do |move|
          if move_number.even?
            @board[move]=-1
            move_number+=1
          else
            @board[move]=1
            move_number+=1
          end
        end
      end
    end
    @board
  end

  def self.computer_move(board)
    computer_array = Array.new
    board.each_with_index do |cell, index|
      if cell==0
        computer_array << index
      else
        nil
      end
    end
    computer_array.sample
  end

  def self.computer_turn(game)
    x = -1
    unless game.moves.empty?
      x = game.moves.last.id-game.moves.first.id
    end
    x.even?
  end

  def self.game_over(board)
    game_over=true
    if board.include? 0
      game_over=false
    end
    game_over
  end

  def self.game_won_by(board)
    two_d_board = board.each_slice(3).to_a
    game_won_by=0
    sums = Array.new

    two_d_board = board.each_slice(3).to_a

    two_d_board.each do |row|
      sums << row.inject(0, &:+).abs
    end
  
    two_d_board.transpose.each do |column|
      sums << column.inject(0, &:+).abs
    end

    diag_one_sum = board[0]+board[4]+board[8]
    diag_two_sum = board[2]+board[4]+board[6]

    sums << diag_one_sum << diag_two_sum
    
    sums.each do |x|
      if x==-3
        game_won_by=-1
      elsif x==3
        game_over=1
      end
    end

    game_won_by
  end

  def self.status(game_over, game_won_by)
    status=false
    unless game_over==false
      if game_over && game_won_by==0 
        status="draw"
      elsif game_over && game_won_by==-1
        status="X"
      else game_over && game_won_by==1
        status="O"
      end
    end
    status
  end


  

end
