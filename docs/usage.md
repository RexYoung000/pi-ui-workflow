# 使用说明（详细版）

> README 的补充文档，含使用示例、调优技巧、常见场景处理、排查问题。

## 场景 1：从零设计新产品

```bash
cd my-new-project
pi
> /ui-workflow 我要做一个面向独立开发者的极简时间追踪工具
```

主控 AI 会：
1. 让你选择执行模式：快速模式 / 标准模式 / 深度模式，并说明预计耗时和质量取舍
2. 扫项目 → 弹窗问关键决策 → 输出需求摘要
3. 弹窗选搜索方式 → 搜素材 → 研究员分析
4. 弹窗勾选额外分析（信息架构/交互/内容）
5. 按执行模式编排专家分析：快速模式偏并行，标准模式两段式，深度模式更严格传递上游报告
6. 保存各专家中间报告到 `docs/ui-workflow/`，方便追溯和后续复跑
7. 整合 `docs/ui-design-spec.md` → 问要不要 HTML 原型
8. 如确认 → 生成 `docs/prototype/*.html`

### 执行模式怎么选

| 模式 | 预计耗时 | 适合场景 | 取舍 |
|------|----------|----------|------|
| 快速模式 | 约 2-4 分钟 | 只想先看设计方向 | 更快，但报告一致性较弱 |
| 标准模式（推荐） | 约 5-8 分钟 | 大多数正式 UI 设计 | 质量和速度平衡 |
| 深度模式 | 约 8-15 分钟 | 重要产品或关键页面 | 最完整，但等待更久、token 成本更高 |

执行过程中会看到阶段性等待反馈。反馈会遵循“阶段编号 + 当前动作 + 为什么做 + 下一步”的格式，例如：

```text
[阶段 1/6] ✅ 执行模式已确认：标准模式（预计 5-8 分钟）
[阶段 2/6] 🔎 正在对齐需求：我会先确认产品目标、用户和关键页面...
[阶段 3/6] 🔍 正在搜索参考素材：用于让设计方向更有依据...
[阶段 4/6] 🧠 正在运行专家分析：form + visual 会先给下游专家打基础...
[阶段 5/6] 🧩 正在整合报告：我会检查形态、视觉、交互、内容之间是否冲突...
[阶段 6/6] ✅ 已完成：最终规范已保存，接下来可选择是否生成 HTML 原型。
```

## 输出文件说明

工作流会生成两类文件：

| 路径 | 作用 |
|------|------|
| `docs/ui-need-summary.md` | 需求摘要，兼容 `/ui-review` 的前置检查 |
| `docs/ui-design-spec.md` | 最终 UI 设计规范，最推荐用户直接阅读 |
| `docs/ui-workflow/00-need-summary.md` | 本次运行的需求摘要归档 |
| `docs/ui-workflow/01-research-report.md` | 参考素材分析报告 |
| `docs/ui-workflow/02-need-report.md` | 需求分析师报告 |
| `docs/ui-workflow/03-form-report.md` | 形态分析师报告 |
| `docs/ui-workflow/04-visual-report.md` | 视觉分析师报告 |
| `docs/ui-workflow/05-ia-report.md` | 信息架构报告（如已选择） |
| `docs/ui-workflow/06-interaction-report.md` | 交互体验报告（如已选择） |
| `docs/ui-workflow/07-content-report.md` | 内容策略报告（如已选择） |
| `docs/ui-workflow/99-ui-design-spec.md` | 最终规范的归档副本 |
| `docs/prototype/*.html` | HTML 原型（如用户确认生成） |

`docs/ui-workflow/` 是运行产物目录，默认不提交到扩展仓库。

## 场景 2：已有产品优化 UI

```bash
cd existing-product
pi
> /ui-workflow 我们现在的 dashboard 太丑了，想重新设计
```

AI 会读项目现有代码，分析师基于现有结构给改造建议。

## 场景 3：只想理清需求（省 token）

```bash
> /ui-align
```

只跑阶段 1，输出 `docs/ui-need-summary.md`。

## 场景 4：有需求文档，直接出设计

```bash
> /ui-review
```

跳阶段 1，直接选择执行模式 → 搜素材 → 分析 → 审核 → 可选原型。

## 场景 5：局部复跑某个专家

```bash
> /ui-rerun 只重跑视觉
> /ui-rerun 只重跑交互
> /ui-rerun 重新整合最终规范
```

适合已经跑过 `/ui-workflow` 或 `/ui-review`，并且 `docs/ui-workflow/` 下已有中间报告的情况。

局部复跑会复用已有报告，减少重复等待和 token 消耗。

## 场景 6：单独调用某个分析师

```bash
> 用 ui-visual-analyst 分析 https://linear.app 的视觉风格
> 用 ui-interaction-analyst 评估 src/pages/dashboard.tsx 的交互体验
> 用 ui-content-analyst 给这个表单写一套文案
```

## 调优技巧

### 改 Agent 的行为

直接编辑 `.pi/agents/<name>.md` 的 system prompt。

### 改 Agent 使用的模型

在 frontmatter 加 `model`（默认不指定，用你的 pi 默认模型）：

```yaml
---
name: ui-visual-analyst
model: glm/glm-5v-turbo
---
```

### 改内置参考网站

编辑 `ui-research-analyst.md` 和两个 prompt template 里的网站列表。

### 改搜索方式选项

编辑 `ui-workflow.md` 和 `ui-review.md` 的阶段 1.5a 部分。

## 排查问题

### `/ui-workflow` 不识别

确认 `.pi/prompts/ui-workflow.md` 存在，运行 `/reload`。

### Agent 调用失败

如果 `ui_workflow_subagent` 提示找不到 Agent，请检查插件是否正确安装：运行 `pi install npm:pi-ui-workflow`，然后在 Pi 中输入 `/reload`。

### design-dna 没被识别

检查 `~/.pi/agent/skills/design-dna/SKILL.md` 是否存在，frontmatter 是否有 name 和 description。

### 分析师报告质量差

- task 太短 → 主控 AI 要把 need 和 research 完整报告贴进 task
- 模型能力不够 → 给该 agent 换更强模型
- system prompt 不清 → 直接改 `.md`
