---
description: 仅执行 UI 工作流的阶段 1.5 + 2 + 3 + 4 —— 搜素材 + 7 个专家分析 + 总审核 + 可选 HTML 原型。前提是已经做过需求对齐。
---

# UI 工作流 —— 审核模式

跑**阶段 1.5（搜索素材）+ 阶段 2（专家分析）+ 阶段 3（总审核）+ 阶段 4（可选 HTML 原型）**。

## 前置检查

1. 用 `read` 检查项目里是否有 `docs/ui-need-summary.md`（之前跑过 `/ui-align` 或 `/ui-workflow` 阶段 1 产生的）
2. 检查 `README.md`、`AGENTS.md`、`package.json` 了解项目背景
3. 如果**没有需求摘要**：提示用户先跑 `/ui-align` 或 `/ui-workflow`

---

## 阶段 1.5：搜索素材 + 调用研究员

**目标**：收集设计参考素材，交给研究员分析。

### 弹窗：选择搜索方式

用 `ask_user_question` 弹窗：

> **「选择搜索方式，我会优先浏览以下网站找参考：godly.website / awwwards.com / mobbin.com / reactbits.dev / supahero.io / 60fps.design / ui-pocket.com / pinterest」**
> A. TinyFish 搜索（推荐，免费，已装好）
> B. 自定义搜索 API —— 请输入 API endpoint 和 key
> C. 跳过搜索

### 弹窗：额外分析选择

用 `ask_user_question` 弹一个多选：

> **「基础分析（需求/形态/视觉/素材）会自动跑。还需要以下额外分析吗？」**
> - ☑ 信息架构分析（导航结构、页面层级、跳转关系）
> - ☑ 交互体验分析（微交互、状态过渡、手势、可访问性）
> - ☑ 内容策略分析（界面文案、提示语、CTA 语调）

### 执行搜索

**选 A（TinyFish）**：
1. `tinyfish_fetch` 抓取内置网站（godly.website / awwwards.com / mobbin.com / reactbits.dev / supahero.io / 60fps.design / ui-pocket.com / pinterest）
2. `tinyfish_search` 搜相关设计参考

**选 B（自定义 API）**：
- 用户输入 endpoint + key → bash curl 调用 + tinyfish_fetch 抓内置网站

**选 C（跳过）**：不搜。

### 调用研究员

用 `subagent` 工具 **single 模式**：

```json
{
  "agent": "ui-research-analyst",
  "task": "<需求摘要 + 搜索结果 + 网站内容>",
  "agentScope": "both",
  "confirmProjectAgents": false
}
```

---

## 阶段 2：专家分析

### 阶段 2a：需求分析（单个）

用 `subagent` 工具 **single 模式**调用 `ui-need-analyst`：

```json
{
  "agent": "ui-need-analyst",
  "task": "<需求摘要全文 + 项目背景>",
  "agentScope": "both",
  "confirmProjectAgents": false
}
```

### 阶段 2b：并行分析

用 `subagent` 工具 **parallel 模式**，每个 task 包含 need 完整报告 + research 完整报告：

```json
{
  "tasks": [
    { "agent": "ui-form-analyst", "task": "## 需求报告\n<need 报告>\n\n## 参考素材报告\n<research 报告>" },
    { "agent": "ui-visual-analyst", "task": "## 需求报告\n<need 报告>\n\n## 参考素材报告\n<research 报告>" }
    // + 用户勾选的可选 agent
  ],
  "agentScope": "both",
  "confirmProjectAgents": false
}
```

按用户勾选加入 `ui-ia-analyst` / `ui-interaction-analyst` / `ui-content-analyst`。

---

## 阶段 3：总审核

1. 检测所有报告之间的冲突
2. 整合为 `docs/ui-design-spec.md`
3. 有冲突用 `ask_user_question` 让用户决策

---

## 阶段 4：HTML 原型（必须二次确认）

用 `ask_user_question`：

> **「是否生成 HTML 原型？」**
> 1. 生成完整 HTML 原型
> 2. 仅生成 1 个关键页面的原型（推荐）
> 3. 仅保留规范文档
> 4. 跳过

如果用户选 1 或 2：读 design-dna SKILL.md → generation-guide.md → 生成 HTML → 写入 `docs/prototype/`

---

## 完成汇报

- ✅ 产出文件清单（路径）
- 📊 跑了哪些 Agent、核心结论
- ⚠️ 待确认问题
- 💡 下一步建议
