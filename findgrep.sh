#!/bin/bash

usage()
{
  #シェルスクリプトのファイル名を取得

  local script_name=$(basename "$0")
  #ヒアドキュメントを表示
  cat << END
Usage: $script_name PATERN [PATH] [NAME_PATTERN]
Find file in current directory recursivery, abd print lines which match
PATERN.

  PATH          find file in PATH directory, instead of current directory
  NAME_PATTERN  specify name pattern to find file

EXAMPLE:
  $script_name return
  $script_name retunr ~ '*.txt'
END
}

#コマンドライン引数が0個の時
if [ "$#" -eq 0 ]; then
  usage
  exit 1
fi
pattern=$1
directory=$2
name=$3

#第2引数が空文字列ならば
#デフォルト値として、カレントディレクトリを設定
if [ -z "$directory" ]; then
  directory='.'
fi

#検索ディレクトリが存在しない場合にエラ＝メッセージを表示して終了
if [ ! -d "$directory" ]; then
  echo "$0: ${directory}: No such directory" 1>&2
  exit 2
fi

find "$directory" -type f -name "$name" | xargs grep -nH "$pattern"
