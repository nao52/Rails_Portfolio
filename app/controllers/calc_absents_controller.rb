class CalcAbsentsController < ApplicationController

  def show
    @carriculum_size = 15
    @carriculums = []
  end

  def set_curriculum
    @carriculum_size = 15
    @carriculums = []
    @carriculum_size.times do |n|
      @carriculums << params["carriculums#{n+1}"] if params["carriculums#{n+1}"].present?
    end
    render 'show', status: :unprocessable_entity
  end

  def set_test_data
    @carriculum_size = 15
    @carriculums = []
    @carriculums = ["英語1", "芸術", "国語1", "理科基礎1", "数学1", "数学A", "体育", "総合的な学習の時間", "LHR", "現代社会", "地理A", "家庭科基礎"]
    render 'show', status: :unprocessable_entity
  end

  def schedule
  end

end
