module LoginMacros
  def login(user)
    visit login_path
    fill_in "session[email]",    with: user.email
    fill_in "session[password]", with: "password"
    click_button 'ログイン'
    expect(page).to have_text "ログインに成功しました！"
  end

  def logout
    click_link 'ログアウト'
    expect(page).to have_text("ログアウトしました")
  end
end