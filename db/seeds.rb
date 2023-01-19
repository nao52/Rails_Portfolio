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