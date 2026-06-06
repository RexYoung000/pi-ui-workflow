#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

ok() { printf "✅ %s\n" "$1"; }
warn() { printf "⚠️  %s\n" "$1"; }
fail() { printf "❌ %s\n" "$1"; }

printf "pi-ui-workflow 安装检查\n"
printf "项目路径：%s\n\n" "$ROOT_DIR"

missing=0

check_file() {
  local path="$1"
  local label="$2"
  if [[ -f "$path" ]]; then
    ok "$label"
  else
    fail "$label 缺失：$path"
    missing=1
  fi
}

check_dir_files() {
  local dir="$1"
  local glob="$2"
  local label="$3"
  local count=0

  if [[ -d "$dir" ]]; then
    while IFS= read -r -d '' _file; do
      count=$((count + 1))
    done < <(find "$dir" -maxdepth 1 -type f -name "$glob" -print0)
  fi

  if (( count > 0 )); then
    ok "${label}（${count} 个文件）"
  else
    fail "$label 未找到：$dir/$glob"
    missing=1
  fi
}

printf "1. 检查本项目资源\n"
check_dir_files "$ROOT_DIR/.pi/agents" "*.md" "项目内 agents"
check_dir_files "$ROOT_DIR/.pi/prompts" "*.md" "项目内 prompts"
check_file "$ROOT_DIR/.pi/prompts/ui-workflow.md" "项目内 /ui-workflow prompt"
check_file "$ROOT_DIR/.pi/prompts/ui-review.md" "项目内 /ui-review prompt"
check_file "$ROOT_DIR/.pi/prompts/ui-align.md" "项目内 /ui-align prompt"
printf "\n"

printf "2. 检查全局安装状态\n"
check_dir_files "$HOME/.pi/agent/agents" "ui-*.md" "全局 UI agents"
check_file "$HOME/.pi/agent/prompts/ui-workflow.md" "全局 /ui-workflow prompt"
check_file "$HOME/.pi/agent/prompts/ui-review.md" "全局 /ui-review prompt"
check_file "$HOME/.pi/agent/prompts/ui-align.md" "全局 /ui-align prompt"
printf "\n"

printf "3. 检查依赖\n"
if [[ -f "$HOME/.pi/agent/extensions/subagent/index.ts" || -f "$HOME/.pi/agent/extensions/subagent/index.js" ]]; then
  ok "subagent 扩展已安装"
else
  warn "subagent 扩展未在 ~/.pi/agent/extensions/subagent/ 下找到"
  warn "请参考 README 的依赖章节安装 subagent 扩展"
fi

if [[ -f "$HOME/.pi/agent/skills/design-dna/SKILL.md" ]]; then
  ok "design-dna skill 已安装"
else
  warn "design-dna skill 未在 ~/.pi/agent/skills/design-dna/SKILL.md 找到"
  warn "如需视觉分析和 HTML 原型，请参考 README 安装 design-dna"
fi
printf "\n"

printf "4. 下一步\n"
if (( missing == 0 )); then
  ok "核心文件检查完成"
else
  warn "存在缺失项，请先按 README 复制 prompts / agents"
fi

printf "如果 Pi 已经打开，请在 Pi 中输入 /reload 后再使用：\n"
printf "  /ui-workflow 我要设计一个极简任务管理工具\n"
