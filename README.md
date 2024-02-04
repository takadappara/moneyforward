# MoneyForward ME
## CSVファイルのダウンロード

ブラウザ Chrome で MoneyForward ME にログインした状態で、下記のようにスクリプトを実行する。  
Chrome でダウンロードしたファイルの保存先は、`~/Download` 前提。  
（動作確認は、MacBook Air (M1, 2020)のみでしか確認していません。）  

1. Chrome で MoneyForward ME にログインする。  
   https://moneyforward.com/
2. ターミナルから、下記のようにスクリプトを実行する。  
   ```shell
   ./download_csv.sh 2020/04 2023/04
   ```
   第１引数は開始年月、第２引数は、終了年月
3. 正常にスクリプトが実行されれば、`./download`ディレクトリが作成され、  
   `収入・支出詳細_2022-04-01_2022-04-30.csv` のような名前のCSVファイルがダウンロードされる。  

参考までに、シェルスクリプト中では、以下のようなコマンドを繰り返して実行している。  
```shell
open -a "Google Chrome" -g https://moneyforward.com/cf/csv?from=2023/01/01&month=1&year=2023
```