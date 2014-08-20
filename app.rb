require 'sinatra'
require "sinatra/reloader" if development?
require 'sinatra/contrib'
require 'erb'
require 'sequel'

set :public_folder, File.dirname(__FILE__) + '/static'
DB = Sequel.connect('postgres://tiny:today@localhost/papa')
Dir["./models/*.rb"].each {|file| require file }

get '/' do
  erb :index
end

post '/article/create' do
  if params[:article][:body].empty? || params[:article][:body].strip.empty?
    redirect '/'
  end

  article = Article.new
  article.ip = request.ip
  article.body = params[:article][:body]
  article.created_at = Time.now

  article.save
  redirect '/'
end
