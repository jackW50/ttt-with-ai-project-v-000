require 'pry'
class Game 
  attr_accessor :board, :player_1, :player_2, :winner
 
  WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  
  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end 
  
  def current_player
    board.turn_count.even? ? player_1 : player_2
  end 
  
  def won?
   WIN_COMBINATIONS.detect do |win_combo|
    board.cells[win_combo[0]] == board.cells[win_combo[1]] && board.cells[win_combo[1]] == board.cells[win_combo[2]] && (board.cells[win_combo[0]] == "X" || board.cells[win_combo[0]] == "O")
     end 
  end 
  
  #binding.pry
  
  def draw? 
    board.full? && !won?
  end 
  
  def over? 
    draw? || won?
  end 
  
  def winner
    if won?
      if board.cells[won?[0]] == "X"
        @winner = "X"
      elsif board.cells[won?[0]] == "O"
        @winner = "O"
      end 
    else 
      nil
    end 
  end 
  
  def turn
    input = current_player.move(board)
    if board.valid_move?(input)
      board.update(input, current_player)
    else 
      turn
    end 
  end 
  
  def play
    if !over?
      turn
      board.display
      puts "Next Move"
      play 
    elsif over?  
      if won?
        puts "Congratulations #{winner}!"
      elsif draw?
        puts "Cat's Game!"
      end
    end 
  end 
  
  def start 
    puts "Hello! Let's play Tic-Tac_Toe!!"
    puts "How many players? 0, 1, or 2"
    players = gets.strip
    if players != 0 || 1 || 2
      "Wha Happened" 
    elsif players == 1 
      puts "Who should go first? User or Computer?"
      first = gets.strip 
      if first != "User" || "Computer"
        puts "1 or 2"
        first = gets.strip
        if first == 1 
          player_1 = Players::Human.new("X")
          player_2 = Players::Computer.new("O")
        elsif first == 2 
          player_1 = Players::Computer.new("X")
          player_2 = Players::Human.new("O")
        else 
          "Wha Happened"
        end 
      elsif first == "User"
        player_1 = Players::Human.new("X")
        player_2 = Players::Computer.new("O")
      elsif first == "Computer"
        player_1 = Players::Computer.new("X")
        player_2 = Players::Human.new("O")
    
end 