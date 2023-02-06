class CalcAbsentsController < ApplicationController
  before_action :set_carriculums

  def show
  end

  def set_curriculum
    30.times do |n|
      @schedules << params["schedule#{n+1}"]
    end
    puts "テスト=#{@schedules}"

    @carriculum_size.times do |n|
      @carriculums << params["carriculums#{n+1}"] if params["carriculums#{n+1}"].present?
    end
    render 'show', status: :unprocessable_entity
  end

  def set_test_carriculum
    @carriculums = ["英語1", "芸術", "国語1", "理科基礎1", "数学1", "数学A", "体育", "総合的な学習の時間", "LHR", "現代社会", "地理A", "家庭科基礎"]
    render 'show', status: :unprocessable_entity
  end

  def schedule
    @carriculums = params[:carriculums].split if params[:carriculums].present?
    30.times do |n|
      @schedules << params["suchedule#{n+1}"]
    end
    render 'show', status: :unprocessable_entity
  end

  def set_test_schedule
    @carriculums = params[:carriculums].split if params[:carriculums].present?
    30.times do |n|
      carriculum = @carriculums.shuffle[0]
      puts "テスト=#{carriculum}"
      @schedules << carriculum
    end
    render 'show', status: :unprocessable_entity
  end

  private

    # beforeフィルタ

    # カリキュラム情報をセット
    def set_carriculums
      @carriculum_size = 15
      @carriculums = []
      @schedules   = []
    end

end
