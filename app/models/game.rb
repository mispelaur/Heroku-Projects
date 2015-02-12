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

  def self.computer_turn(game)#x true if even and < 8
    x = -1
    unless game.moves.empty?
      x = game.moves.last.id-game.moves.first.id
    end
    if x.even? && x<8
      x=true
    else
      x=false
    end
    x
  end

  def self.board_full(board)
    board_full=true
    if board.include? 0
      board_full=false
    end
    board_full
  end

  def self.game_won_by(board)
    two_d_board = board.each_slice(3).to_a
    game_won_by=0
    sums = Array.new

    two_d_board = board.each_slice(3).to_a

    two_d_board.each do |row|
      sums << row.inject(0, &:+)
    end
  
    two_d_board.transpose.each do |column|
      sums << column.inject(0, &:+)
    end

    diag_one_sum = board[0]+board[4]+board[8]
    diag_two_sum = board[2]+board[4]+board[6]

    sums << diag_one_sum << diag_two_sum
    
    sums.each do |x|
      if x==-3
        game_won_by=-1
      elsif x==3
        game_won_by=1
      end
    end

    game_won_by
  end

  def self.status(board_full, game_won_by)
    status=false
    if board_full && game_won_by==0 
      status="draw"
    elsif game_won_by==-1
      status="X"
    elsif game_won_by==1
      status="O"
    end
    status
  end


  

end
