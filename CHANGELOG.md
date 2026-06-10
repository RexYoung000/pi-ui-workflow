# Changelog

本项目遵循语义化版本思路记录变更。

## 0.2.11 - 2026-06-09

### Changed

- 版本号升级以同步 pi.dev 列表页缓存

## 0.2.8 - 2026-06-09

### Added

- `ui-workflow` 新增端口感知质量门：最终审核前先识别 Web、移动 App、Apple 平台、Android、桌面软件、Deck、信息图、Motion 或跨平台目标，再应用对应检查标准。
- 外部 skill 路由新增 `ehmo/platform-design-skills`、`alchaincyf/huashu-design`、`raintree-technology/hig-doctor`、`ceorkm/mobile-app-ui-design`、`AvdLee/SwiftUI-Agent-Skill`。
- `quality-checklist.md` 增加 Web、移动端、桌面软件、Deck/信息图/Motion 的平台专项检查项。

### Changed

- `web-design-guidelines` 调整为 Web 专项审核，不再作为所有端口的默认最终质量标准。
- 原型、动画、PPT、信息图等高保真交付场景优先路由到 `huashu-design`。

## 0.2.0 - 2026-06-06

### Added

- **新增内置 extension**：`extensions/ui-workflow/`，注册 `ui_workflow_subagent` 工具。
- Agent 发现模块自动从 package 内部 `.pi/agents/` 读取 7 个 UI 分析 Agent。
- 用户 `pi install npm:pi-ui-workflow` 后即可使用 `/ui-workflow`，**不再需要手动复制 agents 或安装外部 subagent 扩展**。

### Changed

- 主安装方式改为 `pi install npm:pi-ui-workflow`；手动复制降级为备选方案。
- `/ui-workflow`、`/ui-review`、`/ui-rerun` 的内部调用从 `subagent` 改为 `ui_workflow_subagent`。
- `package.json` 增加 `pi.extensions`、`peerDependencies`、`repository`、`bugs`、`homepage`。
- README 更新安装说明；移除旧 subagent 扩展依赖。
- `docs/package-plan.md` 更新为当前已实现方案。
- 版本号升至 `0.2.0`。

## 0.1.1 - 2026-06-06

### Changed

- 优化 `/ui-workflow` 和 `/ui-review` 的 `ask_user_question` 执行说明，改为短 label + description 的工具友好格式。
- 增加搜索失败兜底：部分参考网站抓取失败时不中断流程，继续使用可用素材。
- 增加 Agent 缺失兜底：subagent 找不到 Agent 时提示运行 `scripts/check-install.sh` 或复制 agents 后 `/reload`。
- 最终汇报中的 token 表述改为“成本/耗时体感”，避免承诺精确 token 统计。

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
