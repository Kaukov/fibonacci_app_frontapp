require 'net/http'
require 'uri'
require 'json'
require 'sinatra'

set :public_folder, __dir__ + '/public'
set :fibonacci_api, 'http://localhost:3000/fibonacci'

get '/' do
  erb :home, locals: {fibonacciPath: '/fibonacci'}, layout: :application
end

get '/fibonacci' do
  table = nil

  if params[:n]
    uri = URI.parse(settings.fibonacci_api + '?n=' + params[:n])

    res = Net::HTTP.get_response(uri)

    table = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)
    table = JSON.parse(res.body)['error'] if res.is_a?(Net::HTTPBadRequest)
  end

  erb :fibonacci, locals: {size: params[:n], table: table, saved: false}, layout: :application
end

post '/fibonacci' do
  table = nil
  saved = false

  if params[:n]
    uri = URI.parse(settings.fibonacci_api)

    res = Net::HTTP.post_form(uri, 'n' => params[:n])

    table = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)
    table = JSON.parse(res.body)['error'] if res.is_a?(Net::HTTPBadRequest)

    saved = true if res.is_a?(Net::HTTPSuccess)
  end

  erb :fibonacci, locals: {size: params[:n], table: table, saved: saved}, layout: :application
end
