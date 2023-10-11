import $ from 'jquery'
import axios from 'modules/axios' //長ったらしいコードをaxios.jsにまとめてインポート


const listenInactiveHeartEvent = (articleId) => { //メソッドを定義する
    $('.inactive-heart').on('click', () => { //対象クラスの要素をクリックした時に
        axios.post(`/articles/${articleId}/like`) //該当のURLにPOSTリクエストを送り
            .then((response) => { //うまく処理できた場合
            if (response.data.status === 'ok') { //もしresponseがokなら
                $('.active-heart').removeClass('hidden') //対象クラスからhiddenを消して表示する
                $('.inactive-heart').addClass('hidden') //逆に対象クラスにはhiddenを追加して非表示にする。
                }
            })
            .catch((e) => { //失敗したら
            window.alert('Error') //アラートを表示し
            console.log(e) //コンソールにもエラーを表示する。
            })
        })

}

const listenActiveHeartEvent = (articleId) => {
    $('.active-heart').on('click', () => {
        axios.delete(`/articles/${articleId}/like`)
        .then((response) => {
            if (response.data.status === 'ok') {
            $('.active-heart').addClass('hidden')
            $('.inactive-heart').removeClass('hidden')
            }
        })
        .catch((e) => {
            window.alert('Error')
            console.log(e)
        })
    })
}

export { //定義したメソッドを他のファイルで使えるように設定。ハッシュを渡している。
  listenInactiveHeartEvent, //ハッシュなので本来は「AA：AA」のように記述するが、両者の値が同じなら省略可。jsのバージョンによってはできないこともあるので注意。
  listenActiveHeartEvent
}