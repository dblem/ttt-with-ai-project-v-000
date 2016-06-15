class Player

  # Provides token setting and getter method for Computer and Human classes

  attr_reader :token

  def initialize(token)
    @token = token
  end

end
