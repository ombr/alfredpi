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
      power = [lights.first.brightness - 10, 0].max
      lights.each do |light|
        light.brightness = power
      end
    end

    def volumeup
      power = [lights.first.brightness + 10, 255].min
      puts power
      lights.each do |light|
        light.brightness = power
      end
    end

    def up
      power = [lights.first.hue + 1000, 65_535].min
      puts power
      lights.each do |light|
        light.hue = power
      end
    end

    def down
      power = [lights.first.hue - 1000, 0].max
      puts power
      lights.each do |light|
        light.hue = power
      end
    end

    def scrollup
      power = [lights.first.saturation + 10, 255].min
      puts power
      lights.each do |light|
        light.saturation = power
      end
    end

    def scrolldown
      power = [lights.first.saturation - 10, 0].max
      puts power
      lights.each do |light|
        light.saturation = power
      end
    end

    def power_up
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
