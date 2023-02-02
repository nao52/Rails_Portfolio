class TestsController < ApplicationController

  def seat_create
    @col = 6
    @row = 6
    @names = []
  end

  def crate_seats
    col = params[:col].to_i
    row = params[:row].to_i

    user_names = []
    fixed_num = []
    fixed_name = {}

    # 座席に入力された名前をセット
    (col * row).times do |n|
      flash["user#{n+1}_fixed"] = true if params["user#{n+1}_fixed"]
      if params[:shuffle] && params["user#{n+1}_fixed"]
        fixed_num << n
        fixed_name[n] = params["user_name#{n+1}"]
      else
        user_names << params["user_name#{n+1}"]
      end
    end

    # 座席のシャッフル
    if params[:shuffle]
      flash[:shuffle] = true
      user_names.shuffle!

      # 固定された名前の挿入
      fixed_num.each do |index|
        user_names.insert(index, fixed_name[index])
      end

    end

    flash[:col] = col
    flash[:row] = row
    flash[:names] = user_names

    flash[:test3] = true
    
    redirect_to test_url
  end

  def add_data

    col = params[:col].to_i
    row = params[:row].to_i

    # names = []
    # (col * row).times do |n|
    #   names << "ナゲ太郎#{n+1}"
    # end

    names = ["青山優雅", "芦戸三奈", "蛙吹梅雨", "飯田天哉", "麗日お茶子", "尾白猿夫", "上鳴電気", "切島鋭児郎", "口田甲司", "砂藤力道", "障子目蔵", "耳郎響香", "瀬呂範太", "常闇踏陰", "轟焦凍", "葉隠透", "爆豪勝己", "緑谷出久", "峰田実", "八百万百", "磯貝悠馬", "岡島大河", "木村正義", "菅谷創介", "杉野友人", "竹林考太郎", "千葉龍之介", "寺坂竜馬", "前原陽斗", "三村航輝", "村松拓也", "吉田大成", "岡野ひなた", "奥田愛美", "片岡メグ", "神崎有希子", "倉橋陽菜乃", "中村 莉桜", "狭間綺羅々", "速水凛香", "原寿美鈴", "不破優月", "矢田桃花", "自律思考固定砲台", "堀部 イトナ", "秋元真夏", "生田 絵梨花", "生駒 里奈", "伊藤寧々", "伊藤万理華", "井上小百合", "衛藤美彩", "川後陽菜", "川村真洋", "齋藤飛鳥", "斎藤ちはる", "斉藤優里", "桜井玲香", "白石麻衣", "高山一実", "中田花奈", "中元日芽香", "永島聖羅", "西野七瀬", "能條 愛未", "橋本奈々未", "畠中清羅", "樋口日奈", "深川麻衣", "星野みなみ", "松村 沙友理", "若月佑美", "和田 まあや", "ナゲ太郎", "ナゲ助", "ナゲ次郎"]
    names = names.shuffle[0..(col * row)]

    flash[:col] = col
    flash[:row] = row
    flash[:names] = names

    redirect_to test_url

  end

  def delete_data
    names = []

    flash[:col] = params[:col].to_i
    flash[:row] = params[:row].to_i
    flash[:names] = names

    redirect_to test_url
  end

end