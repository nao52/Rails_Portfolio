class CalcAbsentsController < ApplicationController
  before_action :preparation_array
  before_action :set_curriculums, only: [:schedule, :set_test_schedule, :calc_absent]
  before_action :set_schedules,   only: [:set_curriculum, :calc_absent]

  def show
  end

  def set_curriculum
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
    30.times do |n|
      @schedules << params["suchedule#{n+1}"]
    end
    render 'show', status: :unprocessable_entity
  end

  def set_test_schedule
    30.times do |n|
      carriculum = @carriculums.shuffle[0]
      puts "テスト=#{carriculum}"
      @schedules << carriculum
    end
    render 'show', status: :unprocessable_entity
  end

  def calc_absent

  end

  private

    # beforeフィルタ

    # 空の配列を準備する
    def preparation_array
      @carriculum_size = 15
      @carriculums = []
      @schedules   = []
    end

    def set_curriculums
      @carriculums = params[:carriculums].split if params[:carriculums].present?
    end

    def set_schedules
      30.times do |n|
        @schedules << params["schedule#{n+1}"]
      end
    end

end
