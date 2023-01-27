class WorksheetsController < ApplicationController
  before_action :logged_in_user,   only: [:new, :create]

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

  private

    def worksheet_params
      params.require(:worksheet).permit(:name, :detail, :file)
    end

end
