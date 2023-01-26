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