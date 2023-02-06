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

  def schedule
  end

end
