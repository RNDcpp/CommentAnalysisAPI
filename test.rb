require './main'
require './cabocha_engine'
bc = BayesianClassifier.new('word_class.db')
cl=bc.classification ARGV[0]
puts ARGV[0]
cl.each do |key,val|
  puts "#{key}:#{val}"
end
get_rate ARGV[0]
