module Sousenkyo
  class Errors
    class EmptyDirectory < StandardError; end

    class MemberNotFound < StandardError; end

    class TicketsNotDetected < StandardError; end

    class TranslationNotFound < StandardError; end
  end
end
