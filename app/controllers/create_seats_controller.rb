class CreateSeatsController < ApplicationController

  def test
  end

  def show
    @col = 6
    @row = 6
    @names = []
    @fixed_seat    = {}
    @disabled_seat = {}
  end

  def update
    @col = params[:col].to_i
    @row = params[:row].to_i

    user_names = []
    index      = []
    fixed_name = {}

    @fixed_seat    = {}
    @disabled_seat = {}

    # 座席に入力された名前をセット(固定される名前を除く)
    (@col * @row).times do |n|

      seat_no = n + 1

      @fixed_seat["#{seat_no}"]    = params["fixed_seat#{seat_no}"]? true : false
      @disabled_seat["#{seat_no}"] = params["disable_seat#{seat_no}"]? true : false

      # 「使用しない席」または「固定された席」の名前は配列に追加しない
      if params["disable#{seat_no}"]
        index << n
      elsif  params[:shuffle] && params["user#{seat_no}_fixed"]
        index << n
        fixed_name[n] = params["user_name#{seat_no}"]
      else
        user_names << params["user_name#{seat_no}"]
      end

    end

    # 座席のシャッフル
    if params[:shuffle]
      user_names.shuffle!  
      @shuffle = true
    end

    index.each do |index|

      # 使用しない席番号にnilを挿入
      user_names.insert(index, nil) if params["disable#{index+1}"]

      # 固定された名前の挿入
      user_names.insert(index, fixed_name[index]) if params["user#{index+1}_fixed"]

    end

    @names = user_names
    
    render 'show', status: :unprocessable_entity
  end

  def add_data

    col = params[:col].to_i
    row = params[:row].to_i

    names = ["青山優雅", "芦戸三奈", "蛙吹梅雨", "飯田天哉", "麗日お茶子", "尾白猿夫", "上鳴電気", "切島鋭児郎", "口田甲司", "砂藤力道",
             "障子目蔵", "耳郎響香", "瀬呂範太", "常闇踏陰", "轟焦凍", "葉隠透", "爆豪勝己", "緑谷出久", "峰田実", "八百万百",
             "磯貝悠馬", "岡島大河", "木村正義", "菅谷創介", "杉野友人", "竹林考太郎", "千葉龍之介", "寺坂竜馬", "前原陽斗", "三村航輝",
             "村松拓也", "吉田大成", "岡野ひなた", "奥田愛美", "片岡メグ", "神崎有希子", "倉橋陽菜乃", "中村莉桜", "狭間綺羅々", "速水凛香",
             "原寿美鈴", "不破優月", "矢田桃花", "自律思考固定砲台", "堀部イトナ", "秋元真夏", "生田絵梨花", "生駒 里奈", "伊藤寧々", "伊藤万理華",
             "井上小百合", "衛藤美彩", "川後陽菜", "川村真洋", "齋藤飛鳥", "斎藤ちはる", "斉藤優里", "桜井玲香", "白石麻衣", "高山一実",
             "中田花奈", "中元日芽香", "永島聖羅", "西野七瀬", "能條愛未", "橋本奈々未", "畠中清羅", "樋口日奈", "深川麻衣", "星野みなみ",
             "松村 沙友理", "若月佑美", "和田 まあや", "ナゲ太郎", "ナゲ助", "ナゲ次郎"]
    names = names.shuffle[0..(col * row)]

    @col   = col
    @row   = row
    @names = names

    @fixed_seat    = {}
    @disabled_seat = {}

    render 'show', status: :unprocessable_entity
  end

  def delete_data
    names = []

    @col   = params[:col].to_i
    @row   = params[:row].to_i
    @names = names

    render 'show', status: :unprocessable_entity
  end

end
