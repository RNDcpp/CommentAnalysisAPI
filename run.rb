require './main'
require './cabocha_engine'
require 'sinatra'
require 'sinatra/json'
require 'uri'
require 'cgi'
set :bind,'0.0.0.0'
set :port,10987
set :haml, :escape_html => true

get '/api' do
  bc = BayesianClassifier.new('word_class.db')
  p text = CGI.escapeHTML(URI::unescape(params[:comment]?params[:comment]:''))
  if(text.length<70&&text.length>0)
    cl=bc.classification(text)
    cl.each do |key,val|
      puts "#{key}:#{val}"
    end
    val = get_rate(text)
    json rate: val,category: cl,status: 'OK'
  else
    json rate: 0,category: 0,status: 'error'
  end
end
get '/' do
  erb :index
end
