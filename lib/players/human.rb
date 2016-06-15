class Human < Player

  # Requires token argument on initialization
  # Inherits token getter from Player class

  # Accepts board as an optional argument but does not use it

  def move(board=[])
    gets.strip
  end

end
