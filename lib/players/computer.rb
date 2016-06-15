class Computer < Player

  # Requires token argument on initialization
  # Inherits token getter from Player class

  attr_reader :opp_token

  # All sets of winning positions for Tic-Tac-Toe

  WIN_COMBINATIONS = [
    [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]
  ]

  # Modified to set opposing token for use in #must_stop_opp

  def initialize(token)
    super
    self.token == "X" ? @opp_token = "O" : @opp_token = "X"
  end

  # Checks for possible win by finding a set of positions from WIN_COMBINATIONS with a blank space and two of its own tokens and returns the array of winning positions

  def can_win(board)
    WIN_COMBINATIONS.find do |array|
      winning_array = array.collect { |i| board.cells[i] }
      token = self.token
      winning_array.sort == [" ", token, token]
    end
  end

  # Finds index of empty position in winning or losing array passed as argument, converts index to position number, and returns position number as a string

  def game_ending_position(array, board)
    index = array.find { |i| board.cells[i] == " " }
    position = index + 1
    position.to_s
  end

  # Accepts board of current game as argument

  def move(board)
    if self.can_win(board) # First, checks to see if it can win
      array = self.can_win(board)
      game_ending_position(array, board)
    elsif self.must_stop_opp(board) # Second, checks to see if it must stop opposing win
      array = self.must_stop_opp(board)
      game_ending_position(array, board)
    else # Third, makes a random move (Game.turn will ensure the move is valid)
      rand(1..9).to_s
    end
  end

  # Checks for possible opposing win by finding a set of positions from WIN_COMBINATIONS with a blank space and two opposing tokens and returns the array of losing positions

  def must_stop_opp(board)
    WIN_COMBINATIONS.find do |array|
      losing_array = array.collect { |i| board.cells[i] }
      token = self.opp_token
      losing_array.sort == [" ", token, token]
    end
  end

end
