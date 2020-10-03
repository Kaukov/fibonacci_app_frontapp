require 'sinatra'

set :public_folder, __dir__ + '/public'
set :fibonacci_api, 'http://localhost:3000/fibonacci'

get '/' do
  erb :home, locals: {fibonacciPath: '/fibonacci'}, layout: :application
end

get '/fibonacci' do
  table = nil # GET http://backapp/fibonacci?n=* (body)

  erb :fibonacci, locals: {size: params[:n], table: table, saved: false}, layout: :application
end

post '/fibonacci' do
  table = nil   # POST http://backapp/fibonacci (body)
  saved = false # POST http://backapp/fibonacci (HTTP stauts == 200)

  erb :fibonacci, locals: {size: params[:n], table: table, saved: saved}, layout: :application
end
