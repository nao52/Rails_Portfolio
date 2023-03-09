class CleaningDutiesController < ApplicationController
  before_action :set_hash

  def test
  end

  def show
    boys_size  = 4
    girls_size = 4
    @group_size    = 4
    @student_size  = 0
    @group_size.times do |n|
      @groups["#{n+1}"] = { name: "", boys_size: boys_size, girls_size: girls_size, total_size: 8}
      boys_size.times do
        @student_size += 1
        @students["#{@student_size}"] = { group_name: "", student_name: "", sex: "男子" }
      end
      girls_size.times do
        @student_size += 1
        @students["#{@student_size}"] = { group_name: "", student_name: "", sex: "女子" }
      end
    end
  end

  def update
    new_group_size = params[:new_group_size].to_i
    group_size     = params[:group_size].to_i
    student_size   = 0
    boys_index  = []
    boys_names  = []
    girls_index = []
    girls_names = []

    new_group_size.times do |n|
      boys_size  = params["boys_size#{n+1}"].to_i
      boys_size  = 4 if boys_size == 0
      girls_size = params["girls_size#{n+1}"].to_i
      girls_size = 4 if girls_size == 0
      total_size = boys_size + girls_size
      group_name = params["group_name#{n+1}"] || ""
      @groups["#{n+1}"] = { name: group_name, boys_size: boys_size, girls_size: girls_size, total_size: total_size }
      
      # 生徒情報をアップデートす
      boys_size.times do
        student_size += 1
        student_name = params["student_name#{student_size}"] || ""
        boys_index << student_size
        boys_names << student_name
        @students["#{student_size}"] = { group_name: group_name, student_name: student_name, sex: "男子" }
      end
      girls_size.times do
        student_size += 1
        student_name = params["student_name#{student_size}"] || ""
        girls_index << student_size
        girls_names << student_name
        @students["#{student_size}"] = { group_name: group_name, student_name: student_name, sex: "女子" }
      end
    end

    # テストデータの導入
    if params[:add_data]
      names = []
      student_size.times do |n|
        names << "ナゲ太郎#{n+1}"
      end
      student_size.times do |n|
        @students["#{n+1}"][:student_name] = names[n]
      end
    end

    # 男子生徒のシャッフル
    if params[:shuffle_boys]
      boys_names.shuffle!
      boys_index.each do |index|
        @students["#{index}"][:student_name] = boys_names[0]
        boys_names.shift
      end
      @shuffle_boys = true
    end
    # 女子生徒のシャッフル
    if params[:shuffle_girls]
      girls_names.shuffle!
      girls_index.each do |index|
        @students["#{index}"][:student_name] = girls_names[0]
        girls_names.shift
      end
      @shuffle_girls = true
    end
    
    @group_size   = new_group_size
    @student_size = student_size

    render 'show', status: :unprocessable_entity
  end

  private

    # beforeフィルタ

    # 画面表示の際に必要なハッシュ値の初期化
    def set_hash
      @groups        = {}
      @students      = {}
    end
    

end
