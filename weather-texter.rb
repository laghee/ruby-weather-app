require 'barometer'
require 'rubygems'
require 'twilio-ruby'

account_sid = "AC1a5daa8532756b120b331c76f7e41153"
auth_token = "d7f180e90e1f5859ffd8fe7d9db97794"

forecast_string = ''

@client = Twilio::REST::Client.new(account_sid, auth_token)
 
def get_localized_weather(location)
  Barometer.new(location).measure
end

def format(forecast)
	forecast.gsub!("partly", "partly\s")
	forecast.gsub!("mostly", "mostly\s")
	forecast.gsub!("chance", "chance\sof\s")
	forecast.gsub("tstorms", "thunderstorms")
end

weather = get_localized_weather('Milan')
tomorrow = Time.now.strftime('%d').to_i + 1

	puts "Today's forecast: " + weather.current.condition.downcase + ' with a low of ' + 
 		weather.today.low.f.to_s + ' and a high of ' + weather.today.high.f.to_s

	forecast_string += "Today's forecast: " + weather.current.condition.downcase + ' with a low of ' + 
 		weather.today.low.f.to_s + ' and a high of ' + weather.today.high.f.to_s + "\n"
 
	weather.forecast.each do |forecast|

		day = forecast.starts_at.day

		if 
			day == tomorrow
			dayName = 'Tomorrow'
		else
			dayName = forecast.starts_at.strftime('%A')
		end

 		puts dayName + ': ' + format(forecast.icon) + ' with a low of ' + 
 			forecast.low.f.to_s + ' and a high of ' + forecast.high.f.to_s

 		forecast_string += dayName + ': ' + format(forecast.icon) + ' with a low of ' + 
 			forecast.low.f.to_s + ' and a high of ' + forecast.high.f.to_s + "\n"
	end

message = @client.account.messages.create(
	:from => "+15597154875",
	:to => "+14139238206",
	:body => "#{forecast_string}"
	)

puts message.to





=begin

Twilio::TwiML::Response.new do |r|

        r.Message "#{@@forecast_string}"

end.text

=end