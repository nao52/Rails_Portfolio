class CleaningDutiesController < ApplicationController

  def show
    @student_num = 30
    @group_num   = 5
  end

  def create_list
    flash[:student_num] = params[:student_num] if params[:student_num]
    flash[:group_num]   = params[:group_num] if params[:group_num]
    redirect_to cleaning_duty_show_url
  end

end
