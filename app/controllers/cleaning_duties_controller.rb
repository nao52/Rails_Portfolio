class CleaningDutiesController < ApplicationController
  before_action :set_hash

  def show
    4.times do |n|
      @groups["#{n+1}"] = { name: "", boys_size: 4, girls_size: 4, total_size: 8}
    end
    @group_size    = @groups.size
    @student_size  = 32
  end

  def update
    new_group_size = params[:new_group_size].to_i
    group_size     = params[:group_size].to_i
    student_size   = 0

    new_group_size.times do |n|
      boys_size  = params["boys_size#{n+1}"].to_i
      boys_size  = 4 if boys_size == 0
      girls_size = params["girls_size#{n+1}"].to_i
      girls_size = 4 if girls_size == 0
      total_size = boys_size + girls_size
      student_size += boys_size + girls_size
      @group_names["#{n+1}"] = params["group_name#{n+1}"]
      @boys_sizes["#{n+1}"] = boys_size
      @girls_sizes["#{n+1}"] = girls_size
      name = params["group_name#{n+1}"] || ""
      @groups["#{n+1}"] = { name: name, boys_size: boys_size, girls_size: girls_size, total_size: total_size }
    end

    # student_size += (new_group_size - group_size) * 8
    
    student_size.times do |n|
      if params["student_name#{n+1}"].nil?
        @student_names["#{n+1}"] = ""
      else
        @student_names["#{n+1}"] = params["student_name#{n+1}"]
      end
    end

    @group_size   = new_group_size
    @student_size = student_size

    render 'show', status: :unprocessable_entity
  end

  private

    # beforeフィルタ

    # 画面表示の際に必要なハッシュ値の初期化
    def set_hash
      @boys_sizes    = {}
      @girls_sizes   = {}
      @group_names   = {}
      @student_names = {}
      @groups        = {}
    end
    

end
