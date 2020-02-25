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
  count = params[:count].to_i || 1
  for i in 1..count do
    User.create(name:Faker::Name.name, email:Faker::Internet.email, bio:Faker::Address.street_address, password:Faker::Address.zip)
  end
  redirect "http://#{ENV['FRONT_URL']}"
end

# Delete all users.
post '/users/destroy' do
  User.destroy_all
  redirect "http://#{ENV['FRONT_URL']}"
end
