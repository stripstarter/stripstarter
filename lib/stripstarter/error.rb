module Stripstarter
  module Error

    class Base < StandardError
      def initialize(msg = nil)
        super(msg)
      end
    end

    class UserMismatch < Base
      def initialize(msg = "User mismatch event")
        super(msg)
      end
    end

    class Unauthorized < Base  
      def initialize(msg = "User is not authorized for this resource")
        super(msg)
      end
    end
  end
end