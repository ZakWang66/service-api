# entry point
require 'sinatra'
require 'faker'

require_relative './models/user'

# Retrieve all users from database.
get '/users' do
    User.all.to_json
end

# Create n users.
post '/users' do
  count = params[:count] == "" ? 1 : params[:count].to_i
  if count < 0 || count > 30
    return error 400, "400 Bad Request"
  end
  for i in 1..count do
    User.create(name:Faker::Name.name, email:Faker::Internet.email, bio:Faker::Address.street_address, password:Faker::Address.zip)
  end
  redirect "http://#{ENV['FRONT_URL']}"
  return status 200
end

# Delete all users.
post '/users/destroy' do
  if User.destroy_all
    redirect "http://#{ENV['FRONT_URL']}"
    return status 200
  else
    return error 500, "500 Internal Error"
  end
end
