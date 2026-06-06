# Changelog

本项目遵循语义化版本思路记录变更。

## 0.1.0 - 2026-06-06

### Added

- 新增 `/ui-workflow`、`/ui-align`、`/ui-review` 三个 UI 工作流入口。
- 新增 7 个 UI 专业子 Agent：
  - `ui-research-analyst`
  - `ui-need-analyst`
  - `ui-form-analyst`
  - `ui-visual-analyst`
  - `ui-ia-analyst`
  - `ui-interaction-analyst`
  - `ui-content-analyst`
- 新增执行模式选择：快速模式、标准模式、深度模式。
- 新增按执行模式编排专家分析：
  - 快速模式偏并行；
  - 标准模式两段式；
  - 深度模式严格传递上游报告。
- 新增中间报告归档目录规范：`docs/ui-workflow/`。
- 新增文字型等待反馈规范，降低工作流执行过程中的黑盒感。
- 新增快速上手说明。
- 新增安装检查脚本：`scripts/check-install.sh`。
- 新增 Package 化方案文档：`docs/package-plan.md`。
- 新增 `package.json`，先声明 Pi 官方支持的 prompts 资源。

### Changed

- 统一 README、usage、`/ui-workflow`、`/ui-review` 中的流程顺序。
- 默认子 Agent 调用范围调整为 `agentScope: "user"`，避免默认跳过项目本地 Agent 安全确认。
- README 增加输出产物说明、Agent 上游输入说明和安全默认值说明。

### Notes

- 当前 Pi package manifest 仅声明 prompts；agents 是否可作为 package 一等资源分发仍需等待进一步确认。
- `docs/ui-workflow/`、`docs/ui-design-spec.md`、`docs/ui-need-summary.md` 和 `docs/prototype/` 属于运行产物，默认不提交。
