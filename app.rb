require 'sinatra'
require "sinatra/reloader" if development?
require 'sinatra/contrib'
require 'erb'
require 'sequel'

set :public_folder, File.dirname(__FILE__) + '/static'
DB = Sequel.connect('postgres://tiny:today@localhost/papa')
Dir["./models/*.rb"].each {|file| require file }

get '/' do
  #@articles = Article.order(Sequel.desc(:created_at))
  @articles = Article.where(:is_delete => false).order(Sequel.desc(:created_at)).limit(12)
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

get '/article/more' do
  #articles= Article.all
  articles = Article.where("is_delete IS FALSE and id < ?", params[:last_article_id]).order(Sequel.desc(:created_at)).limit(12)
  template_str = ""

  (articles || []).each do |article|
    template_str << erb("_article".to_sym, :locals => { article: article })
  end
  if !articles.empty?
    json :status => true, :articles => template_str
  else
    json :status => false
  end
end
