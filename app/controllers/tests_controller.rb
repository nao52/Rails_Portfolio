class TestsController < ApplicationController

  def seat_create
    @col = 6
    @row = 6
    @names = []
  end

  def crate_seats
    col = params[:col].to_i
    row = params[:row].to_i

    names = []
    (col * row).times do |n|
      names << params["name#{n+1}"]
    end

    flash[:col] = col
    flash[:row] = row
    flash[:names] = names
    
    redirect_to test_url
  end

  def seat_shuffle

    names = params[:names].split.shuffle

    flash[:col]   = params[:col].to_i
    flash[:row]   = params[:row].to_i
    flash[:names] = names

    redirect_to test_url
  end

  def add_data

    col = params[:col].to_i
    row = params[:row].to_i

    names = []
    (col * row).times do |n|
      names << "ナゲ太郎#{n+1}"
    end

    flash[:col] = col
    flash[:row] = row
    flash[:names] = names

    redirect_to test_url

  end

  def delete_data
    names = []

    flash[:col] = params[:col].to_i
    flash[:row] = params[:row].to_i
    flash[:names] = names

    redirect_to test_url
  end

end