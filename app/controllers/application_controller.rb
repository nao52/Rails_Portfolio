class ApplicationController < ActionController::Base

  include SessionsHelper

  def hello
    render html: "テスト成功！！"
  end
  
end
