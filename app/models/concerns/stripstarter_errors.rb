module StripstarterErrors

  # Should we have one main error class?
  #
  # class StripstarterError < StandardError
  #   def initialize(msg = nil)
  #     super(msg)
  #   end
  # end

  class UserMismatchError < StandardError
    def initialize(msg = "User mismatch event")
      super(msg)
    end
  end
end