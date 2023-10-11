module TabsHelper

    def add_active_class(path)
      'active' if current_page?(path) # 現在のページが指定したパスのページだったらactiveクラスを追加する処理
    end

  end