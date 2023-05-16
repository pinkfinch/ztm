

class InvalidParentError < StandardError
  def initialize(message)
    # Call the parent's constructor to set the message
    super(message)
  end
end

class NoSuchRoyalError < StandardError
  def initialize(message)
    # Call the parent's constructor to set the message
    super(message)
  end
end
