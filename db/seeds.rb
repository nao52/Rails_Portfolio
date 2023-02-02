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

# 管理ユーザーの作成
User.create!( name:                   "Nao",
              email:                  "admin_user@example.com",
              password:               "nagenage",
              password_confirmation:  "nagenage",
              subject_id:             3,
              club_id:                4,
              kinds_of_school_id:     3
            )

# テストユーザーの作成
subject_size = Subject.all.size
club_size = Club.all.size
kinds_of_school_size = KindsOfSchool.all.size

names = ["青山優雅", "芦戸三奈", "蛙吹梅雨", "飯田天哉", "麗日お茶子", "尾白猿夫", "上鳴電気", "切島鋭児郎", "口田甲司", "砂藤力道", "障子目蔵", "耳郎響香", "瀬呂範太", "常闇踏陰", "轟焦凍", "葉隠透", "爆豪勝己", "緑谷出久", "峰田実", "八百万百", "磯貝悠馬", "岡島大河", "木村正義", "菅谷創介", "杉野友人", "竹林考太郎", "千葉龍之介", "寺坂竜馬", "前原陽斗", "三村航輝", "村松拓也", "吉田大成", "岡野ひなた", "奥田愛美", "片岡メグ", "神崎有希子", "倉橋陽菜乃", "中村莉桜", "狭間綺羅々", "速水凛香", "原寿美鈴", "不破優月", "矢田桃花", "自律思考固定砲台", "堀部 イトナ", "秋元真夏", "生田 絵梨花", "生駒 里奈", "伊藤寧々", "伊藤万理華", "井上小百合", "衛藤美彩", "川後陽菜", "川村真洋", "齋藤飛鳥", "斎藤ちはる", "斉藤優里", "桜井玲香", "白石麻衣", "高山一実", "中田花奈", "中元日芽香", "永島聖羅", "西野七瀬", "能條愛未", "橋本奈々未", "畠中清羅", "樋口日奈", "深川麻衣", "星野みなみ", "松村 沙友理", "若月佑美", "和田 まあや", "ナゲ太郎", "ナゲ助", "ナゲ次郎"]

names.each_with_index do |name, index|
  user_name = name
  email = "example#{index + 1}@example.com"
  password = "nagenage"
  subject_id = rand(subject_size) + 1
  club_id = rand(club_size) + 1
  kinds_of_school_id = rand(kinds_of_school_size) + 1
  User.create!( name:                   user_name,
                email:                  email,
                password:               password,
                password_confirmation:  password,
                subject_id:             subject_id,
                club_id:                club_id,
                kinds_of_school_id:     kinds_of_school_id
              )
end

# ゲストユーザーの作成
User.create!( name:                   "Guest",
              email:                  "guest_user@example.com",
              password:               "nagenage",
              password_confirmation:  "nagenage",
              subject_id:             2,
              club_id:                1,
              kinds_of_school_id:     4
            )

# 100.times do |n|
#   name = "テストユーザー#{n+1}"
#   email = "test#{n+1}@net.com"
#   password = "password"
#   subject_id = rand(subject_size) + 1
#   club_id = rand(club_size) + 1
#   kinds_of_school_id = rand(kinds_of_school_size) + 1
#   User.create!( name:                   name,
#                 email:                  email,
#                 password:               password,
#                 password_confirmation:  password,
#                 subject_id:             subject_id,
#                 club_id:                club_id,
#                 kinds_of_school_id:     kinds_of_school_id
#               )
# end

# データ作成のためのユーザーをセット
users = User.all
admin_user     = users.first
non_admin_user = users.second 

# ユーザーフォローのリレーションシップを作成
following = users[2..50]
followers = users[21..76]
following.each { |followed| admin_user.follow(followed) }
followers.each { |follower| follower.follow(admin_user) }

# subject_posts_tableにテストデータをセット
100.times do |n|
  user_id = rand(5) + 2
  user = User.find(user_id)
  content = "テスト#{n+1}"
  subject_id = rand(subject_size) + 1
  user.subject_posts.create!( content:    content,
                              subject_id: subject_id )
end

# club_posts_tableにテストデータをセット
100.times do |n|
  user_id = rand(5) + 2
  user = User.find(user_id)
  content = "テスト#{n+1}"
  club_id = rand(club_size) + 1
  user.club_posts.create!(  content:  content,
                            club_id:  club_id )
end

# kinds_of_school_posts_tableにテストデータをセット
100.times do |n|
  user_id = rand(5) + 2
  user = User.find(user_id)
  content = "テスト#{n+1}"
  kinds_of_school_id = rand(kinds_of_school_size) + 1
  user.kinds_of_school_posts.create!( content:  content,
                                      kinds_of_school_id:  kinds_of_school_id )
end

# private_groups_tableにテストデータをセット
30.times do |n|
  name   = "テストグループ#{n+1}"
  admin_user.private_groups.create!( name: name )
end

private_group_size = PrivateGroup.all.size
private_group_number = private_group_size + 1
70.times do |n|
  name   = "テストグループ#{n + private_group_number}"
  detail = "プライベートグループ(#{n + private_group_number})です。"
  admin_user.private_groups.create!( name: name, detail: detail )
end

# private_group_posts_tableテストデータをセット
private_group_size = PrivateGroup.all.size
100.times do |n|
  user_id = rand(5) + 1
  user = User.find(user_id)
  content = "テスト#{n+1}"
  private_group_id = rand(private_group_size) + 1
  user.private_group_posts.create!( content:          content,
                                    private_group_id: private_group_id )
end

# ユーザーのグループ参加状況(participations_table)にテストデータをセット
groups = PrivateGroup.all
group_users = users[0..9]
group_users.each do |user|
  groups.each { |group| user.join(group) }
end

# 出版社情報(publishers_table)にテストデータをセット
admin_user.publishers.create!( name: "アイシーピー" )
admin_user.publishers.create!( name: "あすとろ出版" )
admin_user.publishers.create!( name: "旺文社" )
admin_user.publishers.create!( name: "Gakken" )
admin_user.publishers.create!( name: "KADOKAWA" )
admin_user.publishers.create!( name: "金子書房" )
admin_user.publishers.create!( name: "河合出版" )
admin_user.publishers.create!( name: "教英出版" )
admin_user.publishers.create!( name: "桐原書店" )
admin_user.publishers.create!( name: "くもん出版" )
admin_user.publishers.create!( name: "研究社" )
admin_user.publishers.create!( name: "国際日本語普及協会" )
admin_user.publishers.create!( name: "三省堂" )
admin_user.publishers.create!( name: "Ｊリサーチ出版" )
admin_user.publishers.create!( name: "清水書院" )
admin_user.publishers.create!( name: "昇龍堂出版" )
admin_user.publishers.create!( name: "新興出版社啓林館" )
admin_user.publishers.create!( name: "数研出版" )
admin_user.publishers.create!( name: "駿台文庫" )
admin_user.publishers.create!( name: "清風堂書店／フォーラム・Ａ" )
admin_user.publishers.create!( name: "聖文新社" )
admin_user.publishers.create!( name: "世界思想社教学社" )
admin_user.publishers.create!( name: "増進堂・受験研究社" )
admin_user.publishers.create!( name: "大修館書店" )
admin_user.publishers.create!( name: "大和出版" )
admin_user.publishers.create!( name: "帝国書院" )
admin_user.publishers.create!( name: "テキスタント　富士教育出版事業部" )
admin_user.publishers.create!( name: "東京学参" )
admin_user.publishers.create!( name: "東京出版" )
admin_user.publishers.create!( name: "東京書籍" )
admin_user.publishers.create!( name: "南雲堂" )
admin_user.publishers.create!( name: "日栄社" )
admin_user.publishers.create!( name: "二宮書店" )
admin_user.publishers.create!( name: "日本漢字能力検定協会" )
admin_user.publishers.create!( name: "武久出版" )
admin_user.publishers.create!( name: "文英堂" )
admin_user.publishers.create!( name: "文理" )
admin_user.publishers.create!( name: "ベネッセコーポレーション" )
admin_user.publishers.create!( name: "みくに出版" )
admin_user.publishers.create!( name: "明治書院" )
admin_user.publishers.create!( name: "山川出版社" )
admin_user.publishers.create!( name: "吉川弘文館" )

# 「参考書/副教材」情報(reference_books_table)にテストデータをセット
admin_user.reference_books.create!( title: "DUO［デュオ］3.0",                                  publisher_id: 1)
admin_user.reference_books.create!( title: "宮下典男の速解即答 漢文15の秘訣",                   publisher_id: 2)
admin_user.reference_books.create!( title: "山本俊郎の数学ⅠＡⅡＢ 発想の原点①",                publisher_id: 2)
admin_user.reference_books.create!( title: "山本俊郎の数学ⅠＡⅡＢ 発想の原点②図形編",          publisher_id: 2)
admin_user.reference_books.create!( title: "大森茂の生物論述問題の解き方",                      publisher_id: 2)
admin_user.reference_books.create!( title: "石井雅勇の『前置詞』がスーッとわかる本",            publisher_id: 2)
admin_user.reference_books.create!( title: "石井雅勇の『動詞』がスーッとわかる本",              publisher_id: 2)
admin_user.reference_books.create!( title: "高校受験 英熟語必勝トレーニング",                   publisher_id: 3)
admin_user.reference_books.create!( title: "高校入試 グループでまとめて覚える英単語",           publisher_id: 3)
admin_user.reference_books.create!( title: "SAPIX中高部式英文法123＋",                          publisher_id: 3)
admin_user.reference_books.create!( title: "二刀流古文単語634",                                 publisher_id: 3)
admin_user.reference_books.create!( title: "大学入試でる順漢字書き取り・読み方",                publisher_id: 3)
admin_user.reference_books.create!( title: "大学入試即解セミナー音でおぼえる発音・アクセント",  publisher_id: 3)
admin_user.reference_books.create!( title: "リンケージ英語構文100",                             publisher_id: 3)
admin_user.reference_books.create!( title: "決定版　竹岡広信の　英作文が面白いほど書ける本",    publisher_id: 5)
admin_user.reference_books.create!( title: "東大英単語熟語　鉄壁",                              publisher_id: 5)
admin_user.reference_books.create!( title: "角川パーフェクト過去問シリーズ",                    publisher_id: 5)
admin_user.reference_books.create!( title: "新訂　英文解釈考",                                  publisher_id: 6)
admin_user.reference_books.create!( title: "英文構成法（五訂新版）",                            publisher_id: 6)
admin_user.reference_books.create!( title: "アクセス復習プレミアムノート　基本編",              publisher_id: 7)
admin_user.reference_books.create!( title: "現代文と格闘する　三訂版",                          publisher_id: 7)
admin_user.reference_books.create!( title: "入試現代文へのアクセス　基本編",                    publisher_id: 7)
admin_user.reference_books.create!( title: "はじめての入試現代文 正解へのアプローチ",           publisher_id: 7)
admin_user.reference_books.create!( title: "中堅私大古文演習　改訂版",                          publisher_id: 7)
admin_user.reference_books.create!( title: "春つぐる 頻出古文単語480",                          publisher_id: 7)
admin_user.reference_books.create!( title: "「有名」私大古文演習",                              publisher_id: 7)
admin_user.reference_books.create!( title: "入試必須の基礎知識 漢文ポイントマスター",           publisher_id: 7)
admin_user.reference_books.create!( title: "大学入試　でるとこ古典文学史",                      publisher_id: 7)
admin_user.reference_books.create!( title: "ことばはちからダ！ 現代文キーワード",               publisher_id: 7)
admin_user.reference_books.create!( title: "入試漢字マスター１８００＋<プラス>　三訂版",        publisher_id: 7)
admin_user.reference_books.create!( title: "日本史用語集　＜究＞",                              publisher_id: 7)
admin_user.reference_books.create!( title: "判る！ 解ける！ 書ける！ 世界史論述　改訂版",       publisher_id: 7)
admin_user.reference_books.create!( title: "センター試験　直前ワークアウト地理B",               publisher_id: 7)
admin_user.reference_books.create!( title: "高校１年生のための数学Ⅰ",                           publisher_id: 7)
admin_user.reference_books.create!( title: "高校１年生のための数学A",                           publisher_id: 7)
admin_user.reference_books.create!( title: "ハイパー中学英語教室",                              publisher_id: 9)
admin_user.reference_books.create!( title: "現代文解法の新技術",                                publisher_id: 9)
admin_user.reference_books.create!( title: "古文攻略マストアイテム76〈常識・文法・和歌〉",      publisher_id: 9)
admin_user.reference_books.create!( title: "合格古文単語380　改訂版",                           publisher_id: 9)
admin_user.reference_books.create!( title: "重要古文単語315　三訂版",                           publisher_id: 9)
admin_user.reference_books.create!( title: "読解を深める 現代文単語〈評論・小説〉改訂版",       publisher_id: 9)
admin_user.reference_books.create!( title: "頻出現代文重要語700　三訂版",                       publisher_id: 9)
admin_user.reference_books.create!( title: "志望理由書・自己アピールの基本的な書き方",          publisher_id: 9)
admin_user.reference_books.create!( title: "小論文の基本的な書き方",                            publisher_id: 9)
admin_user.reference_books.create!( title: "入試頻出　新国語問題総演習　改訂版",                publisher_id: 9)
admin_user.reference_books.create!( title: "英文解釈の技術100　CD付新装改訂版",                 publisher_id: 9)
admin_user.reference_books.create!( title: "超入門英文解釈の技術60",                            publisher_id: 9)
admin_user.reference_books.create!( title: "基礎からの英作文パーフェクト演習　改訂版",          publisher_id: 9)
admin_user.reference_books.create!( title: "全解説　入試頻出　英語標準問題1100",                publisher_id: 9)
admin_user.reference_books.create!( title: "高校英文法",                                        publisher_id: 10)
admin_user.reference_books.create!( title: "スーパーステップ",                                  publisher_id: 10)
admin_user.reference_books.create!( title: "要点100％",                                         publisher_id: 10)
admin_user.reference_books.create!( title: "くもんの高校入試　完全攻略トレーニング",            publisher_id: 10)
admin_user.reference_books.create!( title: "くもんの式がひらめく！",                            publisher_id: 10)
admin_user.reference_books.create!( title: "くもんのスタートでつまずかない",                    publisher_id: 10)
admin_user.reference_books.create!( title: "くもんの中学基礎がため100％",                       publisher_id: 10)
admin_user.reference_books.create!( title: "高校入試　こわくない",                              publisher_id: 10)

# book_favorites_tableにテストデータをセット
books = ReferenceBook.all
book_favorite_users = users[0..9]
book_favorite_users.each do |user|
  books.each { |book| user.favorite_book(book) }
end

# book_reviews_tableにテストデータをセット
reference_book_size = ReferenceBook.all.size
100.times do |n|
  user_id = rand(5) + 2
  user = User.find(user_id)
  content = "テスト#{n+1}"
  reference_book_id = rand(reference_book_size) + 1
  user.book_reviews.create!( content:           content,
                             reference_book_id: reference_book_id )
end