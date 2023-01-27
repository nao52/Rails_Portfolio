class WorksheetsController < ApplicationController
  before_action :logged_in_user,   only: [:new, :create]

  def new
    @worksheet = current_user.worksheets.build
  end

  def create
    @worksheet = current_user.worksheets.build(worksheet_params)
  end

  private

    def worksheet_params
      params.require(:worksheet).permit(:name, :detail, :file)
    end

end
