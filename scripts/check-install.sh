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
check_file "$ROOT_DIR/extensions/ui-workflow/index.ts" "内置 extension"
printf "\n"

printf "2. 检查全局安装状态\n"
check_dir_files "$HOME/.pi/agent/agents" "ui-*.md" "全局 UI agents"
check_file "$HOME/.pi/agent/prompts/ui-workflow.md" "全局 /ui-workflow prompt"
check_file "$HOME/.pi/agent/prompts/ui-review.md" "全局 /ui-review prompt"
check_file "$HOME/.pi/agent/prompts/ui-align.md" "全局 /ui-align prompt"
printf "\n"

printf "3. 检查扩展和内置 skill\n"
check_file "$ROOT_DIR/extensions/ui-workflow/index.ts" "内置 extension"

if [[ -f "$ROOT_DIR/skills/design-dna/SKILL.md" ]]; then
  ok "design-dna skill（已内置）"
else
  warn "design-dna 未在 ${ROOT_DIR}/skills/design-dna/SKILL.md 找到"
fi

# 旧版兼容提示
if [[ -f "$HOME/.pi/agent/extensions/subagent/index.ts" || -f "$HOME/.pi/agent/extensions/subagent/index.js" ]]; then
  ok "subagent 扩展已安装（旧版兼容）"
else
  ok "subagent 扩展无需独立安装（V0.2.0 已内置）"
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
