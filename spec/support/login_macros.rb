module LoginMacros
  # def login(user)
  #   visit login_path
  #   fill_in 'email', with: user.email
  #   fill_in 'password', with: 'password'
  #   click_button 'ログイン'
  # end

  # def logout
  #   click_link 'ログアウト'
  # end

  # コントローラのテストで使用する
  def is_logged_in?
    !session[:user_id].nil?
  end
  
  def login_as(user)
    post login_path, params: { session: { email:    user.email,
                                          password: 'password' } }
  end
end