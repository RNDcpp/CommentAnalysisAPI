require './main'
require './cabocha_engine'
require 'sinatra'
require 'sinatra/json'
@bc = BayesianClassifier.new('word_class.db')
post '/' do
  cl=@bc.classification(params[:doc])
  cl.each do |key,val|
    puts "#{key}:#{val}"
  end
  json {:rate => get_rate(params[:doc]),:category => cl}
end
