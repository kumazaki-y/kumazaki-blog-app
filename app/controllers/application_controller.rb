class ApplicationController < ActionController::Base # APBから継承。railsで元々膨大な処理が設定されている。
  before_action :set_locale #すべてのコントローラーはこのファイルを継承しているので、ここに書いておけばすべての処理前に絶対に実行される。

    def current_user
        ActiveDecorator::Decorator.instance.decorate(super) if super.present?
        super #deviseとDecoratorの相性が悪くエラーが発生するため、それを解消するコード。
    end

    def default_url_options #元々の設定でビフォーアクションに設定せずとも必ず実行される
      { locale: I18n.locale } #URLがデフォルトの状態でアクセスした時にset_localeメソッドのようなURL表記になる設定
    end
  
    private
    def set_locale #言語国際化メソッドを定義
      I18n.locale = params[:locale] || I18n.default_locale #paramsを取得し、そこに書かれた国名により言語が切り替わる。何もなければデフォルト設定で表示
    end #paramsはroutesで設定する他、params[:〇〇]と定義している場合にURLで「/articles?〇〇=A」のように書くとAの値を取得できる

end
