class PublishersController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @publishers = Publisher.all
  end

  def show
    @publisher = Publisher.find(params[:id])
    @reference_books = @publisher.reference_books
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
    if @publisher.update(publisher_params)
      redirect_to @publisher
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @publisher.destroy
    redirect_to publishers_url, status: :see_other
  end

  private

    def publisher_params
      params.require(:publisher).permit(:name)
    end

    # before フィルタ
    
    # 現在のユーザーが作成者であるか確認
    def correct_user
      @publisher = current_user.publishers.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @publisher.nil?
    end

end
