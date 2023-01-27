module UsersHelper

  # 管理者ユーザーを返す
  def admin_user
    User.first
  end

end
