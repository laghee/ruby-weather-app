require 'barometer'

puts 'Please enter a location (zip, city, state, address, landmark, or airport code): '

location = gets.chomp

barometer = Barometer.new(location)
weather = barometer.measure


time = Time.now.strftime('%A').strip

puts "Current conditions for #{time}: #{weather.current.condition.downcase} "\
		"with a temperature of #{weather.current.temperature.f}°F/#{weather.current.temperature.c}°C."