#-*- coding: utf-8 -*-
require 'cabocha'
require 'pp'
require 'yaml'
# sentenceを係り受け解析して結果ツリーを得る
module CaboCha
  class Token
    def to_s
      @to_s ||= ("".respond_to?("force_encoding"))?normalized_surface.force_encoding('utf-8'):normalized_surface
    end
  end
end
def next_chunk(tree,chunk_id)
  link = tree.chunk(chunk_id).link
  return link>0?tree.chunk(link):nil
end
def tree_depth(tree,chunk_id)
  next_chunk(tree,chunk_id)?(tree_depth(tree,tree.chunk(chunk_id).link) + 1):0
end
def add_params(message,pa,label)
sentence = message.split(/。|．|\n|\r|\t/)
score = 0;
parser = CaboCha::Parser.new;
sentence.each do |sen|
puts sen
tree = parser.parse(sen)
puts "構文のサイズ = #{tree.chunk_size}"
max_depth = 0
m_chunk_length = 0.0
m_word_length = 0.0
for i in  0...tree.chunk_size
  t_ken = ""
  m_chunk_length += tree.chunk(i).token_size
  for j in 0...tree.chunk(i).token_size
    m_word_length += tree.token(tree.chunk(i).token_pos+j).to_s.length
    t_ken += "#{tree.token(tree.chunk(i).token_pos + j).to_s}-"
  end
  depth = tree_depth(tree,i)
  max_depth = [max_depth,depth].max
  puts "depth: {#{depth}} :#{t_ken}"
end
m_chunk_length/=tree.chunk_size
m_word_length/=tree.chunk_size
puts"構文の高さ: #{max_depth} 1チャンクの文字数：#{m_word_length} 　1チャンクの語数：#{m_chunk_length}"
pa << [tree.chunk_size,max_depth,max_depth*max_depth,m_word_length,m_chunk_length,1,label,sen[0,10]]
end
end
#=begin
source = YAML.load_file("source.yml")
data=[]
source.each do |mes|
  p mes
end
source.each do |mes|
  add_params(mes[0],data,mes[1])
end
#=end
=begin
data=[
[1,1,1,1,1,1,5],
[1,1,1,1,1,1,5],
[2,2,2,2,2,1,10],
[3,3,3,3,3,1,15],
[3,3,3,3,3,1,15],
[4,4,4,4,4,1,20],
[2,3,2,3,2,1,13],
[1,2,3,4,5,1,15],
[2,1,3,4,5,1,15],
[0,1,2,3,0,1,6],
[3,0,0,1,2,1,6]
]
=end
mat=[]
mat_y=[0,0,0,0,0,0]
mat[0]=[0,0,0,0,0,0]
mat[1]=[0,0,0,0,0,0]
mat[2]=[0,0,0,0,0,0]
mat[3]=[0,0,0,0,0,0]
mat[4]=[0,0,0,0,0,0]
mat[5]=[0,0,0,0,0,0]
inv_mat=[]
inv_mat[0]=[1,0,0,0,0,0]
inv_mat[1]=[0,1,0,0,0,0]
inv_mat[2]=[0,0,1,0,0,0]
inv_mat[3]=[0,0,0,1,0,0]
inv_mat[4]=[0,0,0,0,1,0]
inv_mat[5]=[0,0,0,0,0,1]
data.each do |p|
  for i in 0...6
    for j in 0...6
      mat[i][j]+=p[i]*p[j]
    end
    mat_y[i]+=p[6]*p[i]
  end
end
mat.each {|a|p a}
puts "==="
mat_y.each{|a|p a}
puts "==="
inv_mat.each{|a|p a}
puts "==="
puts "conv mat \n ..."
for i in 0...6
  p buf = 1.0/mat[i][i]
  for j in 0...6
    inv_mat[i][j]*=buf
    mat[i][j]*=buf
  end
  for j in 0...6
    if i != j
      buf = mat[j][i]
      for k in 0...6
        mat[j][k]-=buf*mat[i][k]
        inv_mat[j][k]-=buf*inv_mat[i][k]
      end
    end
  end
end
mat.each {|a|p a}
puts "==="
mat_y.each{|a|p a}
puts "==="
inv_mat.each{|a|p a}
puts "==="
puts"results:::"
at=[]
for i in 0...6
  a=0
  for j in 0...6
    a+=inv_mat[i][j]*mat_y[j]
  end
  puts at[i] =a# (a/data.length)
end
puts "誤差"
data.each do |p|
  test_v=0
  for i in 0...6
    test_v += at[i]*p[i]
  end
  puts "\"#{p[7]}\""
  puts "#{(((test_v-p[6])/p[6])*10000).to_i/100.0}% "
end
