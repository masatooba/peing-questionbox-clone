# peing-質問箱-のクローン(OSS)
[クローン質問箱](https://qubox.org)の現状はこんな感じです。
![質問箱](https://s3-us-west-1.amazonaws.com/4chat/sread/FireShot+Capture+058+-+qubox+-+%E8%B3%AA%E5%95%8F%E7%AE%B1+-+qubox.org.png "質問箱")

## 質問箱とは
みなさん[peing-質問箱-](https://peing.net/)をご存知ですか?twitterで2017年ごろから流行っている匿名で質問ができるwebサービスのことです。このサービスは個人開発をしているせせり氏が開発したサービスで公開１ヶ月で1億アクセスに達したそうです。

匿名で質問できるという機能はとても面白いと思いました。なのでこれをオープンソース化して、もっといろんな機能をつけていきたいと考えています。

___

### デプロイ deploy
誰でもカンタンにデプロイできるようにしましたので是非みなさんもお使いください。
まずはgitからファイルをダウンロードしてください。

``` git clone git@github.com:seiyatakahashi/peing-questionbox-clone.git ```

ダウンロードができたらダウンロードしてきたフォルダに移動する

``` cd peing-questionbox-clone ```

herokuにログインをする

``` heroku login ```

heorku でプロジェクトを作成する

``` heroku create 作りたいアプリ名 ```

heorku にアップロード

``` git add . ```

``` git commit -m "all" ```

``` git push heroku master ```

アップロードしてら、データベースにマイグレード

``` heroku run rails db:migrate```

環境変数の設定

```  heroku config:set APP_NAME="アプリの名前"```

```  heroku config:set APP_NAME_EN="アプリの英語の表記名"```

```  heroku config:set API_KEY="ツイッターのAPI KEY"```

```  heroku config:set API_SECRET="ツイッターのAPI シークレット"```

```  heroku config:set TOKEN="ツイッターのAccess token"```

```  heroku config:set SECRET="ツイッターのaccess token secret"```

```  heroku config:set CURRENT="自分ののツイッターのID"```

```  heroku config:set DESCRIPTION="サイトの情報"```

```  heroku config:set KEYWORDS="サイトのキーワード"```

```  heroku config:set GOOGLE_ANALYTICS="Google アナリティクスのID"```


___

### 今後つけたい機能
##### 決済機能
質問したい人がお金を払って質問された人がお金をもらえる機能。
##### 複数のSNSログイン
現在twitterでのログインしかできなのでfacebookやlineなどを加えたいです。
##### ネイティブアプリ化
railsをapi化させて、iosやandroidのようなネイティブなアプリケーションを作りたいです。


## 参考
cssのデザインはほとんど、こちらのソースコードを使用しております。

・qiita: 質問箱をOSSにしてみた
https://qiita.com/Syo_pr/items/2aa7e5e34726fae30b29

・github: CloneQuestionBox
https://github.com/syoou/CloneQuestionBox
