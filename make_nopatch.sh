#!/bin/bash
set -e

# 通常版、Loose 版のパッチ前のフォント (Meroit の素) を生成させるプログラム
# Cyroit の生成スクリプトがあるディレクトリに移して使用

# ログをファイル出力させる場合は有効にする (<< "#LOG" をコメントアウトさせる)
<< "#LOG"
LOG_OUT=/tmp/run_ff_ttx.log
LOG_ERR=/tmp/run_ff_ttx_err.log
exec 1> >(tee -a $LOG_OUT)
exec 2> >(tee -a $LOG_ERR)
#LOG

# 個別製作用 (絵文字減らした版は、グリフ数の違いにより calt 設定を作り直す必要があるため)
font_familyname0="Cyroit"
font_familyname1="CyroitLoose"
font_familyname_suffix=""
font_familyname_suffix_opt0="Poe"
font_familyname_suffix_opt1="Poew"

build_fonts_dir="Cyroit.nopatch" # フォントを保管するフォルダ

mkdir -p "${build_fonts_dir}"

./font_generator.sh -${font_familyname_suffix_opt0} -N "${font_familyname0}" -n "${font_familyname_suffix}" auto
mv -f ${font_familyname0}${font_familyname_suffix}*.ttf "${build_fonts_dir}/."

./font_generator.sh -${font_familyname_suffix_opt1} -N "${font_familyname1}" -n "${font_familyname_suffix}" auto
mv -f ${font_familyname1}${font_familyname_suffix}*.ttf "${build_fonts_dir}/."


./run_ff_ttx.sh -x

echo
echo "Finished generating no-patch fonts."
echo

exit 0
