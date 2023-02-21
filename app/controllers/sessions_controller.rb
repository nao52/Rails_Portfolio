class SessionsController < ApplicationController

  def new
    if logged_in?
      redirect_to current_user, status: :see_other
    end
    session[:forwarding_url] = params[:original_url] if session[:forwarding_url].blank?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]
      reset_session
      log_in user
      flash[:success] = "ログインに成功しました！"
      redirect_to forwarding_url || user
    else
      flash.now[:danger] = "ログインに失敗しました..."
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    flash[:success] = "ログアウトしました"
    redirect_to login_url, status: :see_other
  end

end
