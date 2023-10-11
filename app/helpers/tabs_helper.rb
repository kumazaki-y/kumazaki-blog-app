module TabsHelper

    def add_active_class(path)
      path = path.split('?').first #URLの？以降を取得するとバグになるようなので？以前だけを取得するように設定
      'active' if current_page?(path) # 現在のページが指定したパスのページだったらactiveクラスを追加する処理
    end

  end