#!/bin/bash

# Chrome ダウンロードファイルの保存場所
CHROME_DOWNLOAD_DIR=~/Downloads

if [ $# -ne 2 ]; then
  echo "usage: $0 <start_year_month> <end_year_month>"
  echo "   ex) $0 2023/01 2024/01"
  exit 1
fi

start_year=$(echo "$1" | cut -d '/' -f 1)  # 開始年を取得
start_month=$(echo "$1" | cut -d '/' -f 2)  # 開始月を取得
end_year=$(echo "$2" | cut -d '/' -f 1)  # 終了年を取得
end_month=$(echo "$2" | cut -d '/' -f 2)  # 終了月を取得

while [ $start_year -lt $end_year ] || ([ $start_year -eq $end_year ] && [ $start_month -le $end_month ]); do
  printf "%04d/%02d\n" $start_year $start_month  # 年月を表示
  # Chromeでcsvファイルをダウンロード
  open -a "Google Chrome" https://moneyforward.com/cf/csv?from=$start_year/$start_month/01&month=1&year=$start_year
  sleep 1

  if [ $start_month -eq 12 ]; then
    start_month=1
    start_year=$(($start_year + 1))
  else
    start_month=$(($start_month + 1))
  fi
done

# ダウンロード待ち
sleep 5

# downloadディレクトリが存在しない場合に作成
if [ ! -d download ]; then
    mkdir -p download
fi

# ダウンロードしたファイルをdownloadディレクトリに移動
mv $CHROME_DOWNLOAD_DIR/収入・支出詳細_*.csv ./download/
echo "Done."