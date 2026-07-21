#!/bin/bash
# 镜像生成器 一键推送到 GitHub
# 用法: 在文件夹里右键 "Git Bash Here",然后运行  bash push.sh
set -e

read -p "请输入你的 GitHub 用户名(只含字母、数字、连字符): " RAW

# 去掉前后空白
USER="$(echo "$RAW" | tr -d '[:space:]')"
# 只保留 URL 安全的字符:字母、数字、连字符、下划线、点
USER="$(echo "$USER" | tr -cd 'A-Za-z0-9._-')"

if [ -z "$USER" ]; then
  echo "用户名无效(可能含空格或 ? 等符号被自动过滤后变空了),请重新运行并只输入你的账号名。"
  exit 1
fi

echo "使用的用户名: $USER"

# 清掉可能已有的 remote,避免冲突
git remote remove origin 2>/dev/null || true
git remote add origin "https://github.com/${USER}/mirror-generator.git"
git branch -M main

echo ""
echo "正在推送 main 分支..."
echo "(如果弹窗要密码,请用 GitHub 令牌 PAT;若凭据库已存,会自动通过)"
echo ""

git push -u origin main

echo ""
echo "完成! 你的仓库地址:"
echo "  https://github.com/${USER}/mirror-generator"
echo ""
echo "提醒: 仓库里只有模板,你的私人镜子档案(自我蒸馏.md)没有被提交。"
