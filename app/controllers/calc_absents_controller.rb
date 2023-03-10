class CalcAbsentsController < ApplicationController
  before_action :logged_in_user, only: :save_schedule

  def show
    set_carriculum_show
  end

  def save_schedule
    if user_params[:carriculum_schedule].split(',').length == 30
      current_user.update(carriculum_schedule: user_params[:carriculum_schedule])
      flash[:success] = "日課表の保存に成功しました！"
      redirect_to calc_absent_show_url
    else
      flash.now[:danger] = "日課表の保存に失敗しました..."
      set_carriculum_show
      render 'show'
    end
  end

  private

    def user_params
      params.require(:user).permit(:carriculum_schedule)
    end

    def set_carriculum_show
      if logged_in?
        @carriculum_schedule = current_user.carriculum_schedule.split(',')
        carriculums = Carriculum.all
        @user_carriculums = []
        @carriculum_schedule.uniq.each do |index|
          @user_carriculums << carriculums[index.to_i].name
        end
      end
      @user = User.new
      @carriculums = [["科目を設定", ""]]
      Carriculum.all.each_with_index do |carriculum, index|
        @carriculums << [carriculum.name, index]
      end
    end

end
