# subjects_tableに値をセット
Subject.create!( name: "国語" )
Subject.create!( name: "数学" )
Subject.create!( name: "英語" )
Subject.create!( name: "社会" )
Subject.create!( name: "理科" )
Subject.create!( name: "体育" )
Subject.create!( name: "家庭科" )
Subject.create!( name: "音楽" )
Subject.create!( name: "美術" )

# clubs_tableに値をセット
Club.create!( name: "野球" )
Club.create!( name: "サッカー" )
Club.create!( name: "テニス" )
Club.create!( name: "バスケットボール" )
Club.create!( name: "バレーボール" )
Club.create!( name: "ダンス" )
Club.create!( name: "剣道" )
Club.create!( name: "陸上" )
Club.create!( name: "ソフトボール" )
Club.create!( name: "水泳" )
Club.create!( name: "卓球" )
Club.create!( name: "軽音" )
Club.create!( name: "料理" )
Club.create!( name: "英語" )
Club.create!( name: "JRC" )

# kinds_of_schools_tableに値をセット
KindsOfSchool.create!( name: "私立/中学" )
KindsOfSchool.create!( name: "私立/高校" )
KindsOfSchool.create!( name: "私立/中学高校" )
KindsOfSchool.create!( name: "公立/中学" )
KindsOfSchool.create!( name: "公立/高校" )
KindsOfSchool.create!( name: "公立/中学高校" )

# テストユーザーの作成
subject_size = Subject.all.size
club_size = Club.all.size
kinds_of_school_size = KindsOfSchool.all.size
100.times do |n|
  name = "テストユーザー#{n+1}"
  email = "test#{n+1}@net.com"
  password = "password"
  subject_id = rand(subject_size) + 1
  club_id = rand(club_size) + 1
  kinds_of_school_id = rand(kinds_of_school_size) + 1
  User.create!( name:                   name,
                email:                  email,
                password:               password,
                password_confirmation:  password,
                subject_id:             subject_id,
                club_id:                club_id,
                kinds_of_school_id:     kinds_of_school_id
              )
end

# ユーザーフォローのリレーションシップを作成
users = User.all
user = users.first
following = users[2..80]
followers = users[21..100]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# subject_posts_tableにテストデータをセット
30.times do |n|
  user_id = rand(5) + 1
  user = User.find(user_id)
  content = "テスト#{n+1}"
  subject_id = rand(subject_size) + 1
  user.subject_posts.create!( content:    content,
                              subject_id: subject_id )
end

# club_posts_tableにテストデータをセット
30.times do |n|
  user_id = rand(5) + 1
  user = User.find(user_id)
  content = "テスト#{n+1}"
  club_id = rand(club_size) + 1
  user.club_posts.create!(  content:  content,
                            club_id:  club_id )
end

# kinds_of_school_posts_tableにテストデータをセット
30.times do |n|
  user_id = rand(5) + 1
  user = User.find(user_id)
  content = "テスト#{n+1}"
  kinds_of_school_id = rand(kinds_of_school_size) + 1
  user.kinds_of_school_posts.create!( content:  content,
                                      kinds_of_school_id:  kinds_of_school_id )
end

# private_groups_tableにテストデータをセット
user = User.first
3.times do |n|
  name   = "テストグループ#{n+1}"
  user.private_groups.create!( name: name )
end

private_group_size = PrivateGroup.all.size
private_group_number = private_group_size + 1
10.times do |n|
  name   = "テストグループ#{n + private_group_number}"
  detail = "プライベートグループ(#{n + private_group_number})です。"
  user.private_groups.create!( name: name, detail: detail )
end

# private_group_posts_tableテストデータをセット
private_group_size = PrivateGroup.all.size
30.times do |n|
  user_id = rand(5) + 1
  user = User.find(user_id)
  content = "テスト#{n+1}"
  private_group_id = rand(private_group_size) + 1
  user.private_group_posts.create!( content:          content,
                                    private_group_id: private_group_id )
end

# ユーザーのグループ参加状況(participations_table)にテストデータをセット
groups = PrivateGroup.all
user1 = User.first
user2 = User.second
groups.each { |group| user1.join(group) }
groups.each { |group| user2.join(group) }

# 出版社情報(publishers_table)にテストデータをセット
user = User.first
user.publishers.create!( name: "アイシーピー" )
user.publishers.create!( name: "あすとろ出版" )
user.publishers.create!( name: "旺文社" )
user.publishers.create!( name: "Gakken" )
user.publishers.create!( name: "KADOKAWA" )
user.publishers.create!( name: "金子書房" )
user.publishers.create!( name: "河合出版" )
user.publishers.create!( name: "教英出版" )
user.publishers.create!( name: "桐原書店" )
user.publishers.create!( name: "くもん出版" )
user.publishers.create!( name: "研究社" )
user.publishers.create!( name: "国際日本語普及協会" )
user.publishers.create!( name: "三省堂" )
user.publishers.create!( name: "Ｊリサーチ出版" )
user.publishers.create!( name: "清水書院" )
user.publishers.create!( name: "昇龍堂出版" )
user.publishers.create!( name: "新興出版社啓林館" )
user.publishers.create!( name: "数研出版" )
user.publishers.create!( name: "駿台文庫" )
user.publishers.create!( name: "清風堂書店／フォーラム・Ａ" )
user.publishers.create!( name: "聖文新社" )
user.publishers.create!( name: "世界思想社教学社" )
user.publishers.create!( name: "増進堂・受験研究社" )
user.publishers.create!( name: "大修館書店" )
user.publishers.create!( name: "大和出版" )
user.publishers.create!( name: "帝国書院" )
user.publishers.create!( name: "テキスタント　富士教育出版事業部" )
user.publishers.create!( name: "東京学参" )
user.publishers.create!( name: "東京出版" )
user.publishers.create!( name: "東京書籍" )
user.publishers.create!( name: "南雲堂" )
user.publishers.create!( name: "日栄社" )
user.publishers.create!( name: "二宮書店" )
user.publishers.create!( name: "日本漢字能力検定協会" )
user.publishers.create!( name: "武久出版" )
user.publishers.create!( name: "文英堂" )
user.publishers.create!( name: "文理" )
user.publishers.create!( name: "ベネッセコーポレーション" )
user.publishers.create!( name: "みくに出版" )
user.publishers.create!( name: "明治書院" )
user.publishers.create!( name: "山川出版社" )
user.publishers.create!( name: "吉川弘文館" )

# 「参考書/副教材」情報(reference_books_table)にテストデータをセット
user.reference_books.create!( title: "DUO［デュオ］3.0",                                  publisher_id: 1)
user.reference_books.create!( title: "宮下典男の速解即答 漢文15の秘訣",                   publisher_id: 2)
user.reference_books.create!( title: "山本俊郎の数学ⅠＡⅡＢ 発想の原点①",                publisher_id: 2)
user.reference_books.create!( title: "山本俊郎の数学ⅠＡⅡＢ 発想の原点②図形編",          publisher_id: 2)
user.reference_books.create!( title: "大森茂の生物論述問題の解き方",                      publisher_id: 2)
user.reference_books.create!( title: "石井雅勇の『前置詞』がスーッとわかる本",            publisher_id: 2)
user.reference_books.create!( title: "石井雅勇の『動詞』がスーッとわかる本",              publisher_id: 2)
user.reference_books.create!( title: "高校受験 英熟語必勝トレーニング",                   publisher_id: 3)
user.reference_books.create!( title: "高校入試 グループでまとめて覚える英単語",           publisher_id: 3)
user.reference_books.create!( title: "SAPIX中高部式英文法123＋",                          publisher_id: 3)
user.reference_books.create!( title: "二刀流古文単語634",                                 publisher_id: 3)
user.reference_books.create!( title: "大学入試でる順漢字書き取り・読み方",                publisher_id: 3)
user.reference_books.create!( title: "大学入試即解セミナー音でおぼえる発音・アクセント",  publisher_id: 3)
user.reference_books.create!( title: "リンケージ英語構文100",                             publisher_id: 3)
user.reference_books.create!( title: "決定版　竹岡広信の　英作文が面白いほど書ける本",    publisher_id: 5)
user.reference_books.create!( title: "東大英単語熟語　鉄壁",                              publisher_id: 5)
user.reference_books.create!( title: "角川パーフェクト過去問シリーズ",                    publisher_id: 5)
user.reference_books.create!( title: "新訂　英文解釈考",                                  publisher_id: 6)
user.reference_books.create!( title: "英文構成法（五訂新版）",                            publisher_id: 6)
user.reference_books.create!( title: "アクセス復習プレミアムノート　基本編",              publisher_id: 7)
user.reference_books.create!( title: "現代文と格闘する　三訂版",                          publisher_id: 7)
user.reference_books.create!( title: "入試現代文へのアクセス　基本編",                    publisher_id: 7)
user.reference_books.create!( title: "はじめての入試現代文 正解へのアプローチ",           publisher_id: 7)
user.reference_books.create!( title: "中堅私大古文演習　改訂版",                          publisher_id: 7)
user.reference_books.create!( title: "春つぐる 頻出古文単語480",                          publisher_id: 7)
user.reference_books.create!( title: "「有名」私大古文演習",                              publisher_id: 7)
user.reference_books.create!( title: "入試必須の基礎知識 漢文ポイントマスター",           publisher_id: 7)
user.reference_books.create!( title: "大学入試　でるとこ古典文学史",                      publisher_id: 7)
user.reference_books.create!( title: "ことばはちからダ！ 現代文キーワード",               publisher_id: 7)
user.reference_books.create!( title: "入試漢字マスター１８００＋<プラス>　三訂版",        publisher_id: 7)
user.reference_books.create!( title: "日本史用語集　＜究＞",                              publisher_id: 7)
user.reference_books.create!( title: "判る！ 解ける！ 書ける！ 世界史論述　改訂版",       publisher_id: 7)
user.reference_books.create!( title: "センター試験　直前ワークアウト地理B",               publisher_id: 7)
user.reference_books.create!( title: "高校１年生のための数学Ⅰ",                           publisher_id: 7)
user.reference_books.create!( title: "高校１年生のための数学A",                           publisher_id: 7)
user.reference_books.create!( title: "ハイパー中学英語教室",                              publisher_id: 9)
user.reference_books.create!( title: "現代文解法の新技術",                                publisher_id: 9)
user.reference_books.create!( title: "古文攻略マストアイテム76〈常識・文法・和歌〉",      publisher_id: 9)
user.reference_books.create!( title: "合格古文単語380　改訂版",                           publisher_id: 9)
user.reference_books.create!( title: "重要古文単語315　三訂版",                           publisher_id: 9)
user.reference_books.create!( title: "読解を深める 現代文単語〈評論・小説〉改訂版",       publisher_id: 9)
user.reference_books.create!( title: "頻出現代文重要語700　三訂版",                       publisher_id: 9)
user.reference_books.create!( title: "志望理由書・自己アピールの基本的な書き方",          publisher_id: 9)
user.reference_books.create!( title: "小論文の基本的な書き方",                            publisher_id: 9)
user.reference_books.create!( title: "入試頻出　新国語問題総演習　改訂版",                publisher_id: 9)
user.reference_books.create!( title: "英文解釈の技術100　CD付新装改訂版",                 publisher_id: 9)
user.reference_books.create!( title: "超入門英文解釈の技術60",                            publisher_id: 9)
user.reference_books.create!( title: "基礎からの英作文パーフェクト演習　改訂版",          publisher_id: 9)
user.reference_books.create!( title: "全解説　入試頻出　英語標準問題1100",                publisher_id: 9)
user.reference_books.create!( title: "高校英文法",                                        publisher_id: 10)
user.reference_books.create!( title: "スーパーステップ",                                  publisher_id: 10)
user.reference_books.create!( title: "要点100％",                                         publisher_id: 10)
user.reference_books.create!( title: "くもんの高校入試　完全攻略トレーニング",            publisher_id: 10)
user.reference_books.create!( title: "くもんの式がひらめく！",                            publisher_id: 10)
user.reference_books.create!( title: "くもんのスタートでつまずかない",                    publisher_id: 10)
user.reference_books.create!( title: "くもんの中学基礎がため100％",                       publisher_id: 10)
user.reference_books.create!( title: "高校入試　こわくない",                              publisher_id: 10)

# book_favorites_tableにテストデータをセット
user1 = User.first
user2 = User.second
books = ReferenceBook.all[0..49]
books.each { |book| user1.favorite_book(book) }
books.each { |book| user2.favorite_book(book) }