# テストユーザーの作成
100.times do |n|
  name = "テストユーザー#{n+1}"
  email = "test#{n+1}@net.com"
  password = "password"
  User.create!( name:                   name,
                email:                  email,
                password:               password,
                password_confirmation:  password,
              )
end

# ユーザーフォローのリレーションシップを作成
users = User.all
user = users.first
following = users[2..80]
followers = users[21..100]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }