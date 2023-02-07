class CalcAbsentsController < ApplicationController
  before_action :preparation_show
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
      @schedules << carriculum
    end
    render 'show', status: :unprocessable_entity
  end

  def calc_absent
    @monday    = params[:monday].to_i
    @tuesday   = params[:tuesday].to_i
    @wednesday = params[:wednesday].to_i
    @thursday  = params[:thursday].to_i
    @friday    = params[:friday].to_i

    # 日課表から重複を取り除く
    courses = @schedules.uniq

    # 科目ごとの欠席数を初期化
    courses.each do |course|
      @absents["#{course}"] = 0
    end

    # 各曜日の欠席数を計算
    carriculum_monday = @schedules[0..5]
    carriculum_monday.each do |carriculum|
      @absents["#{carriculum}"] += @monday
    end
    carriculum_tuesday = @schedules[6..11]
    carriculum_tuesday.each do |carriculum|
      @absents["#{carriculum}"] += @tuesday
    end
    carriculum_wednesday = @schedules[12..17]
    carriculum_wednesday.each do |carriculum|
      @absents["#{carriculum}"] += @wednesday
    end
    carriculum_thursday = @schedules[18..23]
    carriculum_thursday.each do |carriculum|
      @absents["#{carriculum}"] += @thursday
    end
    carriculum_friday = @schedules[24..29]
    carriculum_friday.each do |carriculum|
      @absents["#{carriculum}"] += @friday
    end

    render 'show', status: :unprocessable_entity
  end

  private

    # beforeフィルタ

    # ページを表示するために必要な要素をセットする
    def preparation_show
      @carriculum_size = 15
      @carriculums = []
      @schedules   = []
      @absents = {}
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
