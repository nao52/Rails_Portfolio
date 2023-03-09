class StaticPagesController < ApplicationController

  def create_seats
    render 'create_seats/show'
  end

  def cleaning_duties
    render 'cleaning_duties/show'
  end

end
