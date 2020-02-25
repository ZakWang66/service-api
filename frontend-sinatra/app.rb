# entry point
require 'sinatra'
require 'net/http'
require 'json'

# retrieve your api host address like this
#   settings.api => "someaddress.ondigitalocean.com"
# set :api, ENV['API_HOST']
# set :api_port, ENV['API_PORT'] || 80

# Show a pretty table of all users... rendered on a html page.
get '/' do
  url = "http://#{ENV['API_HOST']}:#{ENV['API_PORT']}"
  @url_users = "#{url}/users"
  @url_users_destroy = "#{url}/users/destroy"

  @data = JSON.parse(Net::HTTP.get(URI(@url_users)))
  erb :index
end
