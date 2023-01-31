class TestsController < ApplicationController

  def crate_seats
    flash[:col] = params[:col]
    flash[:row] = params[:row]
    redirect_to test_url
  end

  def seat_create
  end

end
