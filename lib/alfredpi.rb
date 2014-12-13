require 'eventmachine'
require 'hue'
require 'alfredpi/version'
require 'alfredpi/keyboard'

module Alfredpi
  def self.start
    # hue = Hue::Client.new
    # hue.lights.each do |light|
    #   lights = {}
    #   lights['all'] << light
    #   %w(Chambre Salon).each do |room|
    #     if light.name.include? room
    #       lights[room] ||= []
    #       lights[room] << light
    #     end
    #   end
    #   puts light.name
    #   puts light.hue
    #   puts light.saturation
    #   puts light.brightness
    # end
    # hue.lights.each do |light|
    #   light.on = true
    # end
    EM.run do
      Keyboard.add_handler(lambda do |buffer|
        return if buffer.include? '_UP'
        puts 'test'
        puts buffer
        return unless /. . KEY_([^ ]*) .*/i.match(buffer)
        key = $1
        puts "KEY : #{key}"
        case key
        when 'POWER'
          hue = Hue::Client.new
          power = hue.lights.first.on?
          puts power
          hue.lights.each { |l| l.on = !power }
        end
      end)
      EM.open_keyboard(Keyboard)
      EM.add_periodic_timer(1) { puts '.' }
    end
  end
end
