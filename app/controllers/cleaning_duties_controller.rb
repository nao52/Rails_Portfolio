class CleaningDutiesController < ApplicationController
  before_action :logged_in_user, only: :save_cleaning_place

  def show
    set_cleaning_duty_show
  end

  # def save_cleaning_place

  # end

  private

    def cleaning_place_params
      params.require(:cleaning_place).permit(:name, :boys_num, :girls_num)
    end

    def set_cleaning_duty_show
      @cleaning_place = CleaningPlace.new
    end

end
