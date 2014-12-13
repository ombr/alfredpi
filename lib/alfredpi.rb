require 'eventmachine'
require 'alfredpi/version'
require 'alfredpi/keyboard'

module Alfredpi
  def self.start
    EM.run do
      Keyboard.add_handler(lambda do |buffer|
        return if buffer.include? '_UP'
        return unless /. . KEY_([^ ]*) .*/i.match(buffer)
        key = $1
        puts "KEY : #{key}"
      end)
      EM.open_keyboard(Keyboard)
      EM.add_periodic_timer(1) { puts '.' }
    end
  end
end
