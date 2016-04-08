#-*- coding: utf-8 -*-
require 'cabocha'
require 'pp'
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
def get_rate(message)
begin
sentence = message.split(/。|．|\n|\r|\t/)
score = 0;
parser = CaboCha::Parser.new;
abc=0.356
sentence.each do |sen|
#puts sen
tree = parser.parse(sen)
#puts "構文のサイズ = #{tree.chunk_size}"
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
#puts"構文の高さ: #{max_depth} 1チャンクの文字数：#{m_word_length} 　1チャンクの語数：#{m_chunk_length}"
at = [
0.02139260226272787,
0.048874199031414545,
-0.007809597729925927,
-0.0020594600103288063,
-0.009541467114037333,
0.51188562277891805
]
sc =[0.1,[(
at[0]*tree.chunk_size +
at[1]*max_depth + 
at[2]*max_depth*max_depth+
at[3]*m_word_length +
at[4]*m_chunk_length +
at[5]
),1].min].max
score+=sc*100
end
puts "\n\n================\n\n"
puts"評価：#{(score/sentence.length).to_i}"
puts"文量：#{sentence.length}"
return (score/sentence.length).to_i
rescue=>e
return 0
end
end
