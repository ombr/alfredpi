require 'eventmachine'
require 'hue'
require 'alfredpi/version'
require 'alfredpi/keyboard'

module Alfredpi
  class Alfred
    def self.hue
      @hue ||= Hue::Client.new
    end

    def self.lights
      hue.lights
    end

    def self.alfred
      @alfred ||= new
    end

    def lights
      self.class.lights
    end

    def volumedown
      power = lights.first.brightness - 50
      lights.each do |light|
        light.brightness = power
      end
    end

    def volumeup
      puts 'TEST VOLUMEUP'
      power = lights.first.brightness + 50
      puts power
      lights.each do |light|
        light.brightness = power
      end
    end

    def power
      puts 'POWER !'
      first = lights.first
      first.refresh
      power = !first.on?
      puts power
      lights.each do |light|
        light.on = power
      end
    end
  end
  def self.start
    EM.run do
      Keyboard.add_handler(lambda do |buffer|
        puts buffer
        return if buffer.include? '_UP'
        return unless /. . KEY_([^ ]*) .*/i.match(buffer)
        key = $1
        puts "KEY : #{key}"
        alfred = Alfred.alfred
        alfred.send(key.downcase) if alfred.respond_to?(key.downcase)
      end)
      EM.open_keyboard(Keyboard)
      EM.add_periodic_timer(1) { puts '.' }
    end
  end
end
