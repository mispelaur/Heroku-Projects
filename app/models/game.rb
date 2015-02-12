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

  def self.check_status
  end




  

end
