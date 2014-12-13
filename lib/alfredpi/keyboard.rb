module Alfredpi
  class Keyboard < EventMachine::Connection
    include EM::Protocols::LineText2
    class << self
      attr_reader :handlers
      def add_handler handler
        @handlers ||= []
        @handlers << handler
      end
    end

    def receive_line(line)
      self.class.handlers.each do |handler|
        handler.call line
      end unless self.class.handlers.nil?
    end
  end
end
