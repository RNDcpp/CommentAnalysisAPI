require './get_doc'
word_hash = Hash.new
=begin
GetDocs.get_list_word '洋食',word_hash,2
GetDocs.get_list_word '日本の男優一覧',word_hash,2
GetDocs.get_list_word 'ライトノベル系レーベル一覧',word_hash,3
GetDocs.get_list_word '日本の漫画雑誌',word_hash,3
GetDocs.get_list_word 'グラビアアイドル一覧',word_hash,2
GetDocs.get_list_word '男性モデル一覧',word_hash,2
GetDocs.get_list_word '女性モデル一覧',word_hash,2
GetDocs.get_list_word 'ポピュラー音楽の音楽家一覧 (日本・個人)',word_hash,2
GetDocs.get_list_word 'ポピュラー音楽の音楽家一覧 (日本・グループ)',word_hash,2
GetDocs.get_list_word 'ポピュラー音楽の音楽家一覧 (グループ) ',word_hash,2
GetDocs.get_list_word '漫才師一覧',word_hash,2
GetDocs.get_list_word '日本の女優一覧',word_hash,2
GetDocs.get_list_word 'プロ野球チーム一覧',word_hash,2
GetDocs.get_list_word 'スポーツ競技一覧',word_hash,2
GetDocs.get_list_word '日本のテレビ番組一覧',word_hash,2
=end
GetDocs.get_list_word 'ゲーム機一覧',word_hash,3
GetDocs.get_list_word '特撮関連人名一覧',word_hash,3
GetDocs.get_list_word '日本の漫画作品一覧_あ行',word_hash,3
GetDocs.get_list_word '日本の漫画作品一覧_か行',word_hash,3
GetDocs.get_list_word '日本の漫画作品一覧_さ行',word_hash,3
GetDocs.get_list_word '日本の漫画作品一覧_た行',word_hash,3
GetDocs.get_list_word '日本の漫画作品一覧_な行',word_hash,3
GetDocs.get_list_word '日本の漫画作品一覧_は行',word_hash,3
GetDocs.get_list_word '日本の漫画作品一覧_ま行',word_hash,3
GetDocs.get_list_word '日本の漫画作品一覧_や行',word_hash,3
GetDocs.get_list_word '日本の漫画作品一覧_ら行',word_hash,3
GetDocs.get_list_word '日本の漫画作品一覧_わ行',word_hash,3
GetDocs.get_list_word '日本の漫画作品一覧_(読切)',word_hash,3
GetDocs.get_list_word '日本のOVA作品一覧',word_hash,3
GetDocs.get_list_word '日本のテレビアニメ作品一覧_あ行',word_hash,3
GetDocs.get_list_word '日本のテレビアニメ作品一覧_か行',word_hash,3
GetDocs.get_list_word '日本のテレビアニメ作品一覧_さ行',word_hash,3
GetDocs.get_list_word '日本のテレビアニメ作品一覧_た行',word_hash,3
GetDocs.get_list_word '日本のテレビアニメ作品一覧_な行',word_hash,3
GetDocs.get_list_word '日本のテレビアニメ作品一覧_は行',word_hash,3
GetDocs.get_list_word '日本のテレビアニメ作品一覧_ま行',word_hash,3
GetDocs.get_list_word '日本のテレビアニメ作品一覧_や行',word_hash,3
GetDocs.get_list_word '日本のテレビアニメ作品一覧_ら行',word_hash,3
GetDocs.get_list_word '日本のテレビアニメ作品一覧_わ・を・ん行',word_hash,3
GetDocs.get_list_word '日本のテレビアニメ作品一覧_アルファベット',word_hash,3
=begin
GetDocs.get_list_word 'コンピュータ用語一覧',word_hash,1
GetDocs.get_list_word 'コンピュータ略語一覧',word_hash,1
GetDocs.get_list_word 'NTTグループ',word_hash,1
=end
GetDocs.get_list_word '日本の企業一覧_(サービス)',word_hash,1
GetDocs.get_list_word '日本の企業一覧_(情報・通信)',word_hash,1
GetDocs.get_list_word '日本の民族系合弁企業の一覧',word_hash,1
GetDocs.get_list_word 'カクテルの一覧',word_hash,2
GetDocs.get_list_word '日本全国の銘菓',word_hash,2
GetDocs.get_list_word '調理法',word_hash,2
GetDocs.get_list_word '日本の珍味一覧',word_hash,2
GetDocs.get_list_word '物理学に関する記事の一覧',word_hash,1
GetDocs.get_list_word '漫画レーベル一覧',word_hash,1
GetDocs.get_list_word 'コンピュータゲームのタイトル一覧',word_hash,3
GetDocs.get_list_word 'アーケードゲームのタイトル一覧',word_hash,3
GetDocs.get_list_word 'アダルトゲーム一覧',word_hash,3
GetDocs.get_list_word '日本の外資系企業の一覧',word_hash,1
GetDocs.get_list_word 'ゲーム会社一覧',word_hash,1
GetDocs.get_list_word '日本の外資系合弁企業の一覧',word_hash,1
#GetDocs.table_reset
word_hash.each do |key,value|
  puts "Input:Word:#{key}"
  word = key
  puts "1:ITビジネステクノロジー 2:グルメエンタメスポーツ 3:サブカル漫画アニメ"
  puts value
  case value.to_s
  when '1'
    GetDocs.lean_word word,'IT_ビジネス_テクノロジー'
  when '2'
    GetDocs.lean_word word,'グルメ_エンタメ_スポーツ'
  when '3'
    GetDocs.lean_word word,'サブカル_漫画_アニメ'
  else
  end
end
