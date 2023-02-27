class WorksheetsController < ApplicationController
  before_action :logged_in_user,   only: [:new, :create]
  before_action :correct_user,     only: [:edit, :update, :destroy]

  def index
    @worksheets = Worksheet.all.page(params[:page]).per(30)
  end

  def new
    @worksheet = current_user.worksheets.build
  end

  def create
    @worksheet = current_user.worksheets.build(worksheet_params)
    @worksheet.file.attach(params[:worksheet][:file])
    if @worksheet.save
      flash[:success] = "新規ワークシートを追加しました！"
      redirect_to worksheets_url
    else
      flash.now[:danger] = "出版社の登録に失敗しました..."
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @worksheet.update(worksheet_params)
      flash[:success] = "ワークシート情報を更新しました！"
      redirect_to worksheets_path
    else
      flash.now[:danger] = "ワークシート情報の編集に失敗しました..."
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    name = @worksheet.name
    @worksheet.destroy
    flash[:danger] = "ワークシート(#{name})を削除しました"
    redirect_back(fallback_location: root_url, status: :see_other)
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
