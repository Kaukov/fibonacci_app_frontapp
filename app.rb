require 'sinatra'

set :public_folder, 'public'

get '/fibonacci' do
  table = nil # GET http://backapp/fibonacci?n=* (body)

  erb :fibonacci, locals: {size: params[:n], table: table, saved: false}, layout: :application
end

post '/fibonacci' do
  table = nil   # POST http://backapp/fibonacci (body)
  saved = false # POST http://backapp/fibonacci (HTTP stauts == 200)

  erb :fibonacci, locals: {size: params[:n], table: table, saved: saved}, layout: :application
end
