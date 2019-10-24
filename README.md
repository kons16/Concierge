# Concierge

## 概要

Concierge(コンシェルジュ)は1対1のチャットにおいて、適切な質問を生成することで会話促進を促すチャットアプリです。  
例えば、Aさん「今日ラーメンを食べた」というメッセージがきたとき、Bさんは「どこのお店？」や「誰と？」などの質問を返すのを適切とみなし、
それらの質問を自動で生成しBさんにのみ生成した質問を表示させます。
![output](https://user-images.githubusercontent.com/31591102/67262923-64f35b80-f4e1-11e9-8b63-eec4e0ac58a1.gif)

## 実装機能

### WebSocketでの双方向通信

RailsのActionCableを利用し、WebSocket上でリアルタイムでのチャットのやり取りが可能です。  
また相手ユーザーがメッセージを入力中のとき、「相手が入力中です」の表示を確認できます。

### 自然言語処理での質問生成

メッセージを分析することで適切な質問を生成します。  
EC2上に質問生成用アプリ(Flask)を立ち上げ、チャットアプリ側(Rails)からAPIを呼ぶ形で質問を得ます。

### ユーザーアイコン

ユーザーはアイコンを設定することができます。  
アップロードされたアイコン画像はS3で管理しています。

### ユーザー検索

個々に登録したキーワードを元にユーザーを検索できます。

## 開発環境

Ruby (2.5.0)  
Ruby on Rails (5.1.7)  
RubyMine
