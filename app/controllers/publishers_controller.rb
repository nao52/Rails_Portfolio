class PublishersController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update]

  def index
    @publishers = Publisher.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

end
