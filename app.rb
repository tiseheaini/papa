require 'sinatra'
require "sinatra/reloader" if development?
require 'sinatra/contrib'
require 'erb'
require 'sequel'

set :public_folder, File.dirname(__FILE__) + '/static'

get '/' do
  erb :index
end

post '/article/create' do
  puts params
end
