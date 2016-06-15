class Game

  attr_accessor :board, :player_1, :player_2
  
  # All sets of winning positions for Tic-Tac-Toe

  WIN_COMBINATIONS = [
    [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]
  ]

  def initialize(player_1=Human.new("X"), player_2=Human.new("O"), board=Board.new)
    self.player_1 = player_1
    self.player_2 = player_2
    self.board = board
  end

  # Returns the instance of the current player

  def current_player
    self.board.turn_count.even? ? self.player_1 : self.player_2
  end

  def draw?
    self.board.cells.all? { |cell| cell == "X" || cell == "O" } unless self.won?
  end

  def over?
    self.won? || self.draw?
  end

  # Runs a complete game

  def play
    puts "Here's the board!"
    self.board.display
    until self.over?
      self.turn
    end
    if self.won?
      puts "Congratulations #{self.winner}!"
    else
      puts "Cats Game!"
    end
  end

  # Used to start a new game with a clear board

  def start
    self.board.reset!
    self.play
  end

  # Runs a turn of the game, with separate procedures for human and computer players

  def turn
    player = self.current_player
    if player.is_a?(Human)
      puts "Please enter a number 1-9:"
      input = player.move
      until self.board.valid_move?(input)
        puts "Sorry, that was not a valid move. Please enter a number 1-9:"
        input = player.move
      end
    elsif player.is_a?(Computer)
      board_state = self.board
      input = player.move(board_state)
      input = player.move(board_state) until self.board.valid_move?(input)
      puts "Beep-bop-boop! PlayerBot chooses location #{input}!"
    end
    self.board.update(input, player)
    self.board.display
  end

  # Used if user enters "WARGAMES" for the player count; computer plays against itself 100 times and provides a count of player 1 wins and ties

  def wargames
    game_count = 0
    tie_count = 0
    win_count = 0
    until game_count == 100
      self.start
      tie_count += 1 unless self.winner
      win_count += 1 if self.winner == self.player_1.token
      game_count += 1
    end
    puts "Beep-bop-boop! I, Player1Bot, won #{win_count.to_s} times! Also, there were #{tie_count.to_s} games of cats!"
  end

  # Returns the winning token as a string

  def winner
    if self.won?
      index = self.won?[0]
      self.board.cells[index]
    end
  end

  # Returns the winning array from WIN_COMBINATIONS (used in #winner)

  def won?
    WIN_COMBINATIONS.find do |array|
      array.all? { |i| self.board.cells[i] == "X" } || array.all? { |i| self.board.cells[i] == "O" }
    end
  end

end
