class CleaningDutiesController < ApplicationController
  before_action :logged_in_user, only: :save_cleaning_place

  def show
    set_cleaning_duty_show
  end

  def save_cleaning_place
    name = cleaning_place_params[:name].split(',')
    boys_num = cleaning_place_params[:boys_num].split(',')
    girls_num = cleaning_place_params[:girls_num].split(',')
    group_size = cleaning_place_params[:group_size].to_i
    cleaning_places = current_user.cleaning_places

    if group_size != name.length
      set_cleaning_duty_show
      return render 'show'
    elsif cleaning_places.present?
      current_user.cleaning_places.destroy_all
    end

    group_size.times do |n|
      @cleaning_place = current_user.cleaning_places.build(name: name[n], boys_num: boys_num[n], girls_num: girls_num[n])
      @cleaning_place.save
    end
    flash[:success] = "掃除担当場所のデータを保存しました！"
    redirect_to cleaning_duty_show_url
  end

  private

    def cleaning_place_params
      params.require(:cleaning_place).permit(:group_size, :name, :boys_num, :girls_num)
    end

    def set_cleaning_duty_show
      @cleaning_places = current_user.cleaning_places if logged_in?
      @cleaning_place = CleaningPlace.new
    end

end
