# Concierge

## 概要

会話を続ける上で重要なことは、「**深堀り**」と「**質問**」だと言われています。  
Concierge(コンシェルジュ)は1対1のチャットにおいて、適切な質問をユーザーに向けて提案することで、**ユーザー同士の会話促進を図るチャットアプリ**です。  
<br />
例えば、Aさんから「今日ラーメンを食べた」というメッセージが届いたとき、Bさんは「どこのお店？」や「誰と？」などの質問を返すのを適切とみなし、
それらの質問を自動で生成後Bさんにのみ生成した質問を表示させます。生成された質問をもとに会話をさらに広げていきましょう!  
![output](https://user-images.githubusercontent.com/31591102/67262923-64f35b80-f4e1-11e9-8b63-eec4e0ac58a1.gif)<br /> 
<br />

## 実装機能

### WebSocketを利用した双方向通信

RailsのActionCableを利用し、WebSocket上でリアルタイムでのチャットのやり取りが可能です。  
また文だけでなく、画像をドラッグ&ドロップすることで画像も送信できます。  
相手ユーザーがメッセージを入力中のときは、「相手ユーザーが入力中です」のメッセージが表示されます。

<img width="400" alt="chatapp-img" src="https://user-images.githubusercontent.com/31591102/73068353-58224180-3eee-11ea-8e51-66947c9edadc.png">


### 自然言語処理での質問生成

メッセージを分析することで適切な質問を生成します。  
EC2上に質問生成用アプリ(Flask)を立ち上げ、チャットアプリ側(Rails)からAPIを呼び質問を得ます。

### ユーザーアイコン

ユーザーはアイコンを設定することができます。  
アップロードされたアイコン画像はS3で管理しています。

### ユーザー検索

個々に登録したキーワードを元にユーザーを検索できます。  
下記gifでは左画面のkonoさんから右画面Itoさんにチャット申請を送っています。  
![output_2](https://user-images.githubusercontent.com/31591102/67465999-4330da80-f681-11e9-9e5d-61f122323d3d.gif)<br /> 
<br />

## インデックス
ユーザーを検索する際、hobiesテーブルのnameをもとに検索を行います。  
hobiesテーブルのnameカラムにインデックスを付与した結果、1万件のレコード検索においてベンチマークが`2.80秒`から`2.08秒`に改善されました。
  
## 開発環境

Ruby (2.6.5p114)  
Ruby on Rails (6.0.2)  
Docker  
RubyMine  

## 環境構築

```
$ git clone https://github.com/kons16/Concierge.git
$ cd Concierge

$ docker-compose build
$ docker-compose up
$ docker-compose run web rails db:create
$ docker-compose run web rails db:migrate
```
