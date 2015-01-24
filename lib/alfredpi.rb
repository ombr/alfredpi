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

    def k1(id)
      return unless id == '00'
      lights.each do |light|
        light.brightness = 255
        light.hue = 1
        light.saturation = 60
      end
    end

    def kvolumedown(id)
      power = [lights.first.brightness - 10, 0].max
      lights.each do |light|
        light.brightness = power
      end
    end

    def kvolumeup(id)
      power = [lights.first.brightness + 10, 255].min
      puts power
      lights.each do |light|
        light.brightness = power
      end
    end

    def kup(id)
      power = [lights.first.hue + 1000, 65_535].min
      puts power
      lights.each do |light|
        light.hue = power
      end
    end

    def kdown(id)
      power = [lights.first.hue - 1000, 0].max
      puts power
      lights.each do |light|
        light.hue = power
      end
    end

    def kscrollup(id)
      power = [lights.first.saturation + 10, 255].min
      puts power
      lights.each do |light|
        light.saturation = power
      end
    end

    def kscrolldown(id)
      power = [lights.first.saturation - 10, 0].max
      puts power
      lights.each do |light|
        light.saturation = power
      end
    end

    def kpower(id)
      return unless id == '00'
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
        return unless /.* (..) KEY_([^ ]*) .*/i.match(buffer)
        id = $1
        key = $2
        alfred = Alfred.alfred
        method = "k#{key.downcase}"
        puts "method : #{method}"
        alfred.send(method, id) if alfred.respond_to?(method)
      end)
      EM.open_keyboard(Keyboard)
      EM.add_periodic_timer(1) { puts '.' }
    end
  end
end
