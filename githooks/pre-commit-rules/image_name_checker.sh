#!/bin/sh
#
# 检查提交内容是否使用了[UIImage imageNamed:@"xxx"]获取图片
# 
set -eu

result=0

msg_color_error='\033[31m'
msg_color_success='\033[32m'
msg_color_warning='\033[33m'
msg_color_none='\033[0m'

checkPattern='imageNamed:@"*"'
if git diff-index -p -M --cached HEAD -- '*.m' | egrep $checkPattern >/dev/null 2>&1
then
  git diff-index -p -M --cached HEAD -- egrep -E $checkPattern '*.m'  >&2
  echo "${msg_color_error}❌禁止使用[UIImage imageNamed:@\"xxx\"]方式获取图片，请使用静态常量作为图片名称。${msg_color_none} \n"
  result=1
fi


exit $result