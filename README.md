# Photozousan

フォト蔵のアルバム写真を一括で取得するgemです。

## Installation

    $ gem build photozousan.gemspec
    $ gem install photozousan-x.x.x

## Usage

    $ download_photozou_images

* donwload photozou-album id?: アルバムIDを入力します。フォト蔵アルバムページURL末尾の数値がアルバムURLとなります。

    http://photozou.jp/photo/list/[ユーザーID]/[アルバムID]

* donwload image limit?(1-1000): 1度にダウンロードする写真ファイルの上限を設定します。奨励値は100です。
* your photozou id?: あなたのフォト蔵ID（メールアドレス）
* your photozou password?: あなたのフォト蔵パスワード
（Twitter/Facebookアカウントでユーザー登録している場合、マイページの「設定」からパスワードを設定する必要があります。）

コマンドを実行したディレクトリに Original_[ダウンロード時刻] というフォルダが作成されます。

全ての写真はそのフォルダにダウンロードされます。

## Contributing

1. Fork it ( https://github.com/irasally/photozousan/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Reques
