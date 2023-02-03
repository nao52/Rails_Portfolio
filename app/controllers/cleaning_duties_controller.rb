class CleaningDutiesController < ApplicationController

  def show
  end

  def update_group
    new_group_size = params[:new_group_size].to_i
    group_size     = params[:group_size].to_i
    student_size   = 0
    group_size.times do |n|
      boys_size  = params["boys_size#{n+1}"].to_i
      girls_size = params["girls_size#{n+1}"].to_i
      student_size += boys_size + girls_size
      flash["boys_size#{n+1}"]  = boys_size
      flash["girls_size#{n+1}"] = girls_size
    end

    if new_group_size
      flash[:group_size] = new_group_size
      student_size += (new_group_size - group_size) * 8
    end

    flash[:student_size] = student_size
    redirect_to cleaning_duty_show_url
  end

end
