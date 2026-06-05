# 使用说明（详细版）

> README 的补充文档，含使用示例、调优技巧、常见场景处理、排查问题。

## 场景 1：从零设计新产品

```bash
cd my-new-project
pi
> /ui-workflow 我要做一个面向独立开发者的极简时间追踪工具
```

主控 AI 会：
1. 扫项目 → 弹窗问关键决策 → 输出需求摘要
2. 弹窗选搜索方式 → 搜素材 → 研究员分析
3. 弹窗勾选额外分析（信息架构/交互/内容）
4. 跑 need → 跑 5 个专家并行
5. 整合 `docs/ui-design-spec.md` → 问要不要 HTML 原型
6. 如确认 → 生成 `docs/prototype/*.html`

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

跳阶段 1，直接搜素材 → 分析 → 审核 → 可选原型。

## 场景 5：单独调用某个分析师

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

### subagent 调用失败

检查 `~/.pi/agent/extensions/subagent/index.ts` 和 `agents.ts` 是否存在，`/reload` 一次。

### design-dna 没被识别

检查 `~/.pi/agent/skills/design-dna/SKILL.md` 是否存在，frontmatter 是否有 name 和 description。

### 分析师报告质量差

- task 太短 → 主控 AI 要把 need 和 research 完整报告贴进 task
- 模型能力不够 → 给该 agent 换更强模型
- system prompt 不清 → 直接改 `.md`
