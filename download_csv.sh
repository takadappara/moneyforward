#!/bin/bash

if [ $# -ne 2 ]; then
  echo "usage: $0 <start_year_month> <end_year_month>"
  exit 1
fi

start_year=$(echo "$1" | cut -d '/' -f 1)  # 開始年を取得
start_month=$(echo "$1" | cut -d '/' -f 2)  # 開始月を取得
end_year=$(echo "$2" | cut -d '/' -f 1)  # 終了年を取得
end_month=$(echo "$2" | cut -d '/' -f 2)  # 終了月を取得

while [ $start_year -lt $end_year ] || [ $start_month -le $end_month ]; do
  printf "%04d/%02d\n" $start_year $start_month  # 年月を表示
  # Chromeでcsvファイルをダウンロード
  open -a "Google Chrome" https://moneyforward.com/cf/csv?from=$start_year/$start_month/01&month=1&year=$start_year

  if [ $start_month -eq 12 ]; then
    start_month=1
    start_year=$(($start_year + 1))
  else
    start_month=$(($start_month + 1))
  fi
done

