class Board

  attr_accessor :cells

  # For all methods that accept an "input" argument, the input will be a string "1" - "9" obtained from the player

  def initialize
    self.cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def display
    puts " #{self.cells[0]} | #{self.cells[1]} | #{self.cells[2]} "
    puts "-----------"
    puts " #{self.cells[3]} | #{self.cells[4]} | #{self.cells[5]} "
    puts "-----------"
    puts " #{self.cells[6]} | #{self.cells[7]} | #{self.cells[8]} "
  end

  def full?
    self.cells.none? { |cell| cell == " " }
  end

  def position(input)
    p = input.to_i - 1
    self.cells[p]
  end

  def reset!
    self.cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def taken?(input)
    position = self.position(input)
    position == "X" || position == "O"
  end

  def turn_count
    turn_count = 0
    self.cells.each { |cell| turn_count += 1 unless cell == " " }
    turn_count
  end

  def update(input, player)
    p = input.to_i - 1
    self.cells[p] = player.token if self.valid_move?(input)
  end

  def valid_move?(input)
    position = input.to_i
    position > 0 && position < 10 && !self.taken?(input)
  end

end
