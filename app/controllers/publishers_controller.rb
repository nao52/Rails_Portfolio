class PublishersController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update]

  def index
    @publishers = Publisher.all
  end

  def new
    @publisher = current_user.publishers.build
  end

  def create
    @publisher = current_user.publishers.build(publisher_params)
    if @publisher.save
      redirect_to publishers_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  private

    def publisher_params
      params.require(:publisher).permit(:name)
    end

end
