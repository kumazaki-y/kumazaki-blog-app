class Api::ApplicationController < ApplicationController 
end

    #コントローラーディレクトリを新たに作ったら基本appコントローラーも作っておく。
    #ディレクトリ内のファイルすべてに適用させたいビフォーアクション等がある時にここで設定すればよいため
    #クラス名にはApi::のようにディレクトリ名をつけるルール