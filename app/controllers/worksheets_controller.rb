class WorksheetsController < ApplicationController
  before_action :logged_in_user,   only: [:new, :create]
  before_action :correct_user,     only: [:edit, :update]

  def new
    @worksheet = current_user.worksheets.build
  end

  def create
    @worksheet = current_user.worksheets.build(worksheet_params)
    @worksheet.file.attach(params[:worksheet][:file])
    if @worksheet.save
      redirect_to worksheets_user_path(current_user)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  private

    def worksheet_params
      params.require(:worksheet).permit(:name, :detail, :file)
    end

    # before フィルタ
    
    # 現在のユーザーが作成者であるか確認
    def correct_user
      @worksheet = current_user.worksheets.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @worksheet.nil?
    end

end
