import os
import sys
import pandas as pd

# 無視リスト
IGNORE_LIST = "./ignore_expense_list.csv"
# 出力ファイル名
OUTPUT_FILE = "./expense_output.csv"


def main(csv_file):
    # CSVファイルがなければ抜ける
    if not os.path.exists(csv_file):
        print(f"No such file. {csv_file}")
        exit()

    # CSVファイルを読み込む
    df = pd.read_csv(csv_file, encoding='cp932')

    # 計算対象外を除外する
    df = df[df["計算対象"] == 1]

    # 収入は除外する
    df = df[df["金額（円）"] < 0]

    # 支出をマイナスからプラスにする
    df["金額（円）"] = -1 * df["金額（円）"]

    # 無視リストがある場合
    if os.path.exists(IGNORE_LIST):
        # 無視リストを読み込む
        df_ignore = pd.read_csv(IGNORE_LIST)

        # 無視リストにある項目を削除する
        for _, row in df_ignore.iterrows():
            df = df[~df[row['列名']].str.contains(row['値'], regex=True)]

    # 不要な列の削除
    df = df.drop(columns=["計算対象", "ID", "保有金融機関", "中項目", "振替"])

    # Dataframeの順番を逆順にする(日付が古い順に)
    df = df[::-1]

    # DataFrameを表示
    print("===== 全データを表示 =====")
    print(df)

    # 重複データがあれば表示
    print("===== 重複データを表示 =====")
    print(df.groupby(["日付", "金額（円）"]).filter(lambda x: len(x) > 1))

    # CSVに保存する
    df.to_csv(OUTPUT_FILE, index=False)


if __name__ == '__main__':
    args = sys.argv
    main(args[1])
