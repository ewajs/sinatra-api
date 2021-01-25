# webapi.rb
require 'sinatra'
require 'json'

# We require gyoku here in order to use it in the
# XML route.
require 'gyoku'

users = {
  thibault: { first_name: 'Thibault', last_name: 'Denizet', age: 25 },
  simon:    { first_name: 'Simon', last_name: 'Random', age: 26 },
  john:     { first_name: 'John', last_name: 'Smith', age: 28 }
}

before do
  content_type 'application/json'
end

get '/' do
  'Master Ruby Web APIs - Chapter 2'
end

# Looping through the list of routes for which
# we want to return a JSON representation.
['/users', '/users.json'].each do |path|
  get path do
    users.map { |name, data| data.merge(id: name) }.to_json
  end
end

# Defining /users.xml with the application/xml media type
# and simply calling Gyoku on our users hash with a root
# element 'users'.
get '/users.xml' do
  content_type 'application/xml'
  Gyoku.xml(users: users)
end