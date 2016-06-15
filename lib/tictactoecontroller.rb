class TicTacToeController

  attr_accessor :player_count, :answer
  attr_reader :game

  def initialize
    self.answer = "maybe"
    puts "Welcome to Tic-Tac-Toe!"
    self.set_players
    self.player_count == "WARGAMES"? self.game.wargames : self.game.play
    self.new_game? until self.answer == "no" || self.answer == "n" # Gets will loop until user enters "yes" or "no"
    puts "Thank you for playing!"
  end

  # Creates a new game with appropriate players if none exists, otherwise assigns players according to player count

  def set_players
    puts "How many people are going to play (0, 1, or 2)?"
    self.player_count = gets.strip
    self.player_count = gets.strip until self.player_count.to_i < 3 || self.player_count == "WARGAMES"
    if self.player_count == "1"
      puts "Who should go first? Please enter 'human' or 'computer'."
      first_player = gets.strip.downcase
      first_player = gets.strip.downcase until first_player == "human" || first_player == "computer"
      if first_player == "human"
        if self.game
          self.game.player_1 = Human.new("X")
          self.game.player_2 = Computer.new("O")
        else
          @game = Game.new(Human.new("X"), Computer.new("O"))
        end
      elsif first_player == "computer"
        if self.game
          self.game.player_1 = Computer.new("X")
          self.game.player_2 = Human.new("O")
        else
          @game = Game.new(Computer.new("X"), Human.new("O"))
        end
      end
    elsif self.player_count == "2"
      if self.game
        self.game.player_1 = Human.new("X")
        self.game.player_2 = Human.new("O")
      else
        @game = Game.new
      end
    elsif self.player_count == "0"
      if self.game
        self.game.player_1 = Computer.new("X")
        self.game.player_2 = Computer.new("O")
      else
        @game = Game.new(Computer.new("X"), Computer.new("O"))
      end
    elsif self.player_count == "WARGAMES"
      puts "Secret mode unlocked!"
      if self.game
        self.game.player_1 = Computer.new("X")
        self.game.player_2 = Computer.new("O")
      else
        @game = Game.new(Computer.new("X"), Computer.new("O"))
      end
    end
  end

  # Asks user if they want a new game and sets parameters accordingly

  def new_game?
    puts "Would you like to play again? (Yes / No)"
    self.answer = gets.strip.downcase
    if self.answer == "yes" || self.answer == "y"
      self.set_players
      self.player_count == "WARGAMES"? self.game.wargames : self.game.start
    end
  end

end
