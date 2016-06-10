require 'sinatra'
require 'httparty'
require 'json'

post '/webhook' do
  # Rewind the body in case someone already read it
  request.body.rewind
  # Grab the POST data from API.AI
  @data = JSON.parse request.body.read
  city_name = @data["result"]["parameters"]["geo-city"]
  # do something with your API here and respond_message
  respond_message "Booking a hotel in #{city_name}"
end

def respond_message message
  content_type :json
  # look at the API.AI Webhook/Slack examples for how this works. It's a little bit complicated if you want to add images or more dynamic content, this is where you would do it.
  {:speech => message, :displayText => message, :data => { :slack => { :text => message } }, :source => "Hotel Bot"}.to_json
end
