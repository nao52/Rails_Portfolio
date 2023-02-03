class CleaningDutiesController < ApplicationController

  def show
    @student_num = 30
  end

  def create_list
    flash[:student_num] = params[:student_num]
    redirect_to cleaning_duty_show_url
  end

end
