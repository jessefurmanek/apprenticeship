require 'sinatra'

get '/hello/:name' do
  "Hello #{params['name']}!"
end

