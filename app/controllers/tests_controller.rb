class TestsController < ApplicationController

  def crate_seats
    col = params[:col].to_i
    row = params[:row].to_i

    names = []
    (col*row).times do |n|
      names << params["name#{n+1}"]
    end

    flash[:col] = params[:col].to_i
    flash[:row] = params[:row].to_i
    flash[:names] = names
    
    redirect_to test_url
  end

  def seat_create
    @col = 6
    @row = 6
    @names = []
  end

end