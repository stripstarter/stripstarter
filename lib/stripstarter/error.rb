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

    class NoUser < Base
      def initialize(msg = "Current user required for this action")
        super(msg)
      end
    end

    class NoPledge < Base
      def initialize(msg = "No pledge was found to meet the requirements")
        super(msg)
      end
    end

    class NoPerformance < Base
      def initialize(msg = "No performance was found to attach this photo to.")
        super(msg)
      end
    end
  end
end