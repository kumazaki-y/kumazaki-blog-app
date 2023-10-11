import Rails from '@rails/ujs';
import axios from 'axios'
import { csrfToken } from '@rails/ujs'; ////yarn add rails-ujsをターミナルで実行必要。application以外のファイルでもこれらを読み込む必要がある

axios.defaults.headers.common['X-CSRF-Token'] = Rails.csrfToken();

export default axios //このファイルのエクスポート形式を指定。通常ハッシュでエクスポートするが、デフォルトに設定するとインポート先の記述が楽