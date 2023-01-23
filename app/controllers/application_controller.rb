class ApplicationController < ActionController::Base

  include SessionsHelper

  # ログイン済みのユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url, status: :see_other
    end
  end

  def hello
    render html: "テスト成功！！"
  end
  
end
