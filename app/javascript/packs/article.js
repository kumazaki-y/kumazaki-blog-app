import $, { escapeSelector } from 'jquery' //膨大なモジュールの中からjqueryを読み込み使用できるようになる
import axios from 'modules/axios' //長ったらしいコードをaxios.jsにまとめて、そこからインポート

import {
    listenInactiveHeartEvent, //別ファイルで定義したメソッドを読み込む。
    listenActiveHeartEvent
  } from 'modules/handle_heart' //どのファイルから読み込むか記述する。


const handleHeartDisplay = (hasLiked) => { //コードの可読性を上げるためにメソッドを定義
    if (hasLiked) {//hasLikedがtureなら指定したクラスからhiddenクラスを取り除き、それぞれの画像を表示させる。
        $('.active-heart').removeClass('hidden')
    } else {
        $('.inactive-heart').removeClass('hidden')
    }
    }

  const handleCommentForm = () => {
    $('.show-comment-form').on('click', () => { //対象クラスがクリックされたら下記のイベント実行。
        $('.show-comment-form').addClass('hidden') //対象クラスにクラス追加して非表示にして
        $('.comment-text-area').removeClass('hidden') //逆にクラスを取り除いて表示する。
      })
  }
  
  const appendNewComment = (comment) => {
    $('.comments-container').append( //対象クラスにhtml要素を追加するメソッド
    `<div class="article_comment"><p>${escapeSelector(comment.content)}</p></div>` //コメントを表示する。escapeがあるとxss攻撃へのセキュリティ対策になる。
  )
  }

document.addEventListener('DOMContentLoaded', () => { //railsは「DOMContentLoaded」ではなく「turbolinks:load」でないと動かない。
    const dataset = $('#article-show').data() //まずarticle-showのdataを取得する。このdataの値には記事のIDと同じ値が入っている。
    const articleId = dataset.articleId //さらに記事のIDも取得する。

    axios.get(`/api/articles/${articleId}/comments`) //コメントのURLにリクエスト
    .then((response) => {
      const comments = response.data //レスポンスからコメントデータを取得
      comments.forEach((comment) => { //each文でデータを個々に抜き出し繰り返しイベント内の処理を実行。
        appendNewComment(comment)
      })
    })


    handleCommentForm()

      $('.add-comment-button').on('click', () => {
        const content = $('#comment_content').val() //対象クラスの値を取得
        if (!content) { //もしコンテントに値が無ければ
          window.alert('コメントを入力してください') //アラートを表示する
        } else { //値があれば
          axios.post(`/api/articles/${articleId}/comments`, { //対象URLにPOSTリクエストを送り
            comment: {content: content} //送信データはコメントコントローラーで指定されているparamsの値が{comment: {content: 'aaa'}}のようになっているので同様に記述。
          })
            .then((res) => { //処理ができたら
              const comment = res.data //レスポンスされたデータを取得し
              appendNewComment(comment)
              $('#comment_content').val('') //さらに入力フォームを空にする。
            })
        }
      })
    


    axios.get(`/api/articles/${articleId}/like`) //axiosでdataと記事IDのURLにGETリクエストを送る。
      .then((response) => {
        console.log(response)
        const hasLiked = response.data.hasLiked //検証ツールのコンソールのXHRでresponseのdataを確認するとhasLikedのハッシュ（jsにおいてはオブジェクト）が存在するので取得する。
        handleHeartDisplay(hasLiked)
      })

      listenInactiveHeartEvent(articleId) //インポートしたメソッド。引数も渡す必要がある。
      listenActiveHeartEvent(articleId)

  })