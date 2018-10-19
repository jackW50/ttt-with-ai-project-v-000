module Players
  class Computer < Player
    
    WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    def move(board) 
      input = rand(1..9)
      
      if board.turn_count == 0 
        input = "5"
        
      elsif board.turn_count == 1 && center(board) == " "
        input = "5"
        
      elsif board.turn_count == 1 && center(board) != " "
        input = "7"
        
      elsif board.turn_count == 2
        input = opposite_corner(board) || open_corner(board)  
        
      elsif board.turn_count == 3  
        input = counter_attack(board) || opposite_corner(board) || open_corner(board) 
        
      else 
        input = go_for_win(board) || counter_attack(board) || open_corner(board) || rand(1..9)
      end 
      
      input 
    end
  
  
  
    def center(board)
      board.cells[4]
    end 
  
    def corner_1(board)
      board.cells[0]
    end 
  
    def corner_2(board)
      board.cells[2]
    end 
  
    def corner_3(board)
      board.cells[6]
    end 
  
    def corner_4(board)
      board.cells[8]
    end 
  
    def top_edge(board)
      board.cells[1]
    end 
  
    def bottom_edge(board)
      board.cells[7]
    end 
  
    def left_edge(board)
      board.cells[3]
    end 
  
    def right_edge(board)
      board.cells[5]
    end 
    
    def corners(board)
      [corner_1(board), corner_2(board), corner_3(board), corner_4(board)]
    end 
    
    def open_corner(board)
      if corner_1(board) == " "
        "1"
      elsif corner_2(board) == " " 
        "3"
      elsif corner_3(board) == " "
        "7"
      elsif corner_4(board) == " "
        "9"
      else 
        nil 
      end 
    end 
  
    def opposite_corner(board)
      if corner_1(board) != " "
        "9"
      elsif corner_2(board) != " "
        "7"
      elsif corner_3(board) != " "
        "3"
      elsif corner_4(board) != " "
        "1"
      else 
        nil 
      end 
    end 
  
  #  def corner_furthest(board)
   #   if top_edge(board) != " " && corner_3(board) == " " 
   #     "7"
  #    elsif if top_edge(board) != " " && corner_4(board) == " "
   #     "9"
  #    elsif bottom_edge(board) != " " && corner_1(board) == " "
   #     "1"
   #   elsif bottom_edge(board) != " " && corner_2(board) == " "
  #      "3"
  #    elsif left_edge(board) != " " && corner_2(board) == " "
  #      "3" 
  #    elsif left_edge(board) != " " && corner_4(board) == " "
   #     "9"
  #    elsif right_edge(board) != " " && corner_1(board) == " "
  #      "1"
  #    elsif right_edge(board) != " " && corner_3(board) == " "
  #      "3"
 #     else 
  #     nil 
  #    end 
  #  end 
  
    def almost_winner_x(board)
      WIN_COMBINATIONS.detect do |win_combo|
            (board.cells[win_combo[0]] == "X" && board.cells[win_combo[1]] == "X" && board.cells[win_combo[2]] == " ") || (board.cells[win_combo[0]] == " " && board.cells[win_combo[1]] == "X" && board.cells[win_combo[2]] == "X") || (board.cells[win_combo[0]] == "X" && board.cells[win_combo[1]] == " " && board.cells[win_combo[2]] == "X")
      end 
    end
  
    def almost_winner_o(board)
      WIN_COMBINATIONS.detect do |win_combo|
            (board.cells[win_combo[0]] == "O" && board.cells[win_combo[1]] == "O" && board.cells[win_combo[2]] == " ") || (board.cells[win_combo[0]] == " " && board.cells[win_combo[1]] == "O" && board.cells[win_combo[2]] == "O") || (board.cells[win_combo[0]] == "O" && board.cells[win_combo[1]] == " " && board.cells[win_combo[2]] == "O")
      end 
    end
  
    def almost_winner(board)
      if almost_winner_x(board).is_a?(Array)
        almost_winner_x(board)
      elsif almost_winner_o(board).is_a?(Array)
        almost_winner_o(board)
      else 
        nil
      end 
    end 
  
    def counter(board)
      if almost_winner(board) == nil
        nil
      else 
        almost_winner(board).detect do |spot|
          board.cells[spot] == " "
        end 
      end 
    end 
    
    def counter_attack(board)
      if counter(board) != nil
        (counter(board) + 1).to_s
      elsif counter(board) == nil  
        nil 
      end 
    end 
    
    def win?(board)
      if almost_winner_x(board).is_a?(Array) && token == "X"
        almost_winner_x(board).detect do |spot|
          board.cells[spot] == " "
        end 
      elsif almost_winner_o(board).is_a?(Array) && token == "O"
        almost_winner_o(board).detect do |spot|
          board.cells[spot] == " "
        end 
      else 
        nil 
      end
    end 
    
    def go_for_win 
      if win?(board).is_a(Integer)
        (win?(board) + 1).to_s
      elsif win?(board) == nil 
        nil
      end 
    end 
        
  end 
end 