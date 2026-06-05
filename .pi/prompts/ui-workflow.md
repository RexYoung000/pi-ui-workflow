---
description: UI 工作流完整流程 —— 对齐需求 → 搜索素材 → 7 个专家分析 → 总审核 → 可选 HTML 原型
argument-hint: "[产品/功能的简要描述]"
---

# UI 工作流（完整版）

你现在是 UI 工作流的**总审核人**。你要严格按下面的阶段执行，每个阶段清晰汇报进度。**用户输入的描述是：$@**

---

## 阶段 1：对齐需求

**目标**：在调用任何子 Agent 之前，理解用户要做什么。

1. 用 `read` / `ls` / `find` 检查项目里是否已有 `README.md`、`AGENTS.md`、`docs/`、`package.json`、已有 UI 代码等。
2. 如果信息足够，用 `ask_user_question` 确认 2-3 个关键方向（每问最多 4 个问题）。常见关键决策：
   - 产品形态（Web / 移动 / 桌面 / 多端）
   - 目标用户（专业用户 / 大众 / 企业内部）
   - 风格调性（专业克制 / 活泼现代 / 极简优雅 / 奢华精致）
   - MVP 范围
3. 如果信息严重不足，分两轮问，**不要一次堆太多问题**。
4. 用一段中文总结「我理解的需求」，让用户确认。

### 1.1 弹窗：额外分析选择

需求确认后，用 `ask_user_question` 弹一个多选：

> **基础分析（需求/形态/视觉/素材）会自动跑。还需要以下额外分析吗？**
> - ☑ 信息架构分析（导航结构、页面层级、跳转关系）
> - ☑ 交互体验分析（微交互、状态过渡、手势、可访问性）
> - ☑ 内容策略分析（界面文案、提示语、CTA 语调）
> 默认全勾，用户可取消。

### 1.2 保存需求摘要

用 `write` 把阶段 1 对齐的结果保存到 `docs/ui-need-summary.md`：

```markdown
# UI 需求摘要
- **产品定位**：<一句话>
- **目标用户**：<谁>
- **核心功能（P0/P1/P2）**：
- **关键页面**：
- **约束与偏好**：<技术栈 / 平台 / 品牌调性 / 参考产品>
- **额外分析**：<用户勾选了哪些>
- **待确认问题**：<如果有>
```

---

## 阶段 1.5：搜索素材 + 调用研究员

**目标**：收集设计参考素材，交给研究员分析。

### 1.5a：弹窗选择搜索方式

用 `ask_user_question` 弹窗：

> **「选择搜索方式，我会优先浏览以下网站找参考：godly.website / awwwards.com / mobbin.com / reactbits.dev / supahero.io / 60fps.design / ui-pocket.com / pinterest」**
>
> A. **TinyFish 搜索**（推荐，免费，已装好）—— 搜索全网 + 浏览内置网站
> B. **自定义搜索 API** —— 请输入 API endpoint 和 key
> C. **跳过搜索** —— 不搜素材，研究员基于已有描述直接分析

### 1.5b：执行搜索

**如果选 A（TinyFish）**：
1. 用 `tinyfish_fetch` 抓取内置网站内容（每次最多 10 个 URL，分批抓）：
   - `https://godly.website`
   - `https://www.awwwards.com`
   - `https://mobbin.com`
   - `https://reactbits.dev/components/magic-bento`
   - `https://supahero.io`
   - `https://60fps.design`
   - `https://www.ui-pocket.com/mobile`
   - `https://www.pinterest.com/search/pins/?q=ui+design+inspiration`
2. 用 `tinyfish_search` 搜索相关设计参考（结合用户产品类型和风格调性来搜）：
   - 例如："`<产品类型>` design inspiration 2025"
   - 例如："`<风格>` UI design examples"
   - 例如："`<竞品>` website design analysis"

**如果选 B（自定义 API）**：
- 让用户输入 endpoint 和 key
- 用 `bash` curl 调用该 API 搜索
- 同时用 `tinyfish_fetch` 抓取内置网站

**如果选 C（跳过）**：
- 不搜素材。研究员仍然会被调用（基于需求摘要和有限信息做分析）。

### 1.5c：调用研究员

用 `subagent` 工具的 **single 模式**调用 `ui-research-analyst`：

```json
{
  "agent": "ui-research-analyst",
  "task": "<需求摘要 + 搜索到的素材内容 + 内置网站的抓取结果>",
  "agentScope": "both",
  "confirmProjectAgents": false
}
```

**重要**：task 里要把搜到的素材内容尽量详细地写进去。研究员看不到你的对话，只能看到这个 task。如果选了"跳过搜索"，也要在 task 里说明情况。

---

## 阶段 2：专家分析

### 阶段 2a：需求分析（单个）

用 `subagent` 工具 **single 模式**调用 `ui-need-analyst`：

```json
{
  "agent": "ui-need-analyst",
  "task": "<阶段 1 确认的需求摘要 + 项目背景 + 用户原始描述>",
  "agentScope": "both",
  "confirmProjectAgents": false
}
```

需求分析师产出完整的需求报告，这份报告是阶段 2b 所有专家的权威输入。

### 阶段 2b：形态 + 视觉 + 可选分析（并行）

用 `subagent` 工具 **parallel 模式**，调用以下 agent。**每个 task 都要包含**：need 报告的全部内容 + research 报告的全部内容。

```json
{
  "tasks": [
    {
      "agent": "ui-form-analyst",
      "task": "基于以下需求报告和参考素材报告，给出 UI 形态决策：\n\n## 需求报告\n<need 完整报告>\n\n## 参考素材报告\n<research 完整报告>"
    },
    {
      "agent": "ui-visual-analyst",
      "task": "基于以下需求报告和参考素材报告，给出视觉规范。如有参考 URL 请调用 design-dna skill：\n\n## 需求报告\n<need 完整报告>\n\n## 参考素材报告\n<research 完整报告>"
    }
    // 以下按用户勾选添加，如果用户勾了 ia：
    {
      "agent": "ui-ia-analyst",
      "task": "基于以下需求报告、形态报告和参考素材报告，给出信息架构：\n\n## 需求报告\n<need 完整报告>\n\n## 参考素材报告\n<research 完整报告>"
    },
    // 如果用户勾了 interaction：
    {
      "agent": "ui-interaction-analyst",
      "task": "基于以下需求报告、形态报告、视觉报告和参考素材报告，给出交互体验方案：\n\n## 需求报告\n<need 完整报告>\n\n## 参考素材报告\n<research 完整报告>"
    },
    // 如果用户勾了 content：
    {
      "agent": "ui-content-analyst",
      "task": "基于以下需求报告、形态报告和参考素材报告，给出内容策略：\n\n## 需求报告\n<need 完整报告>\n\n## 参考素材报告\n<research 完整报告>"
    }
  ],
  "agentScope": "both",
  "confirmProjectAgents": false
}
```

**关键提示**：
- `agentScope: "both"` 必填
- `confirmProjectAgents: false` 跳过安全确认
- 每个 task **必须把 need 报告和 research 报告的完整内容贴进去**，因为子 Agent 看不到之前的对话
- 可选的 agent 只加入用户勾选的那些
- 所有 task 同时并行跑，总耗时 ≈ 最慢的那个

---

## 阶段 3：总审核

**目标**：整合所有报告，产出一份最终的设计规范。

### 3.1 检测冲突

对比所有报告，找出不一致的地方。常见冲突：
- need 说"移动优先"，但 form 的断点策略没体现
- form 推荐了暗色主题库，但 visual 给的是亮色
- ia 给了 4 级深导航，但 interaction 建议键盘快捷键操作
- content 的风格是"亲切活泼"，但 visual 的配色是银行级的深蓝
- 等等

### 3.2 整合最终文档

用 `write` 写到 `docs/ui-design-spec.md`。结构：

```markdown
# UI 设计规范 —— <产品名>
> 由 UI 工作流自动生成，整合自 N 份分析报告

## 1. 产品定位与目标（来自 need 报告）
## 2. 关键页面与形态（来自 form 报告）
## 3. 信息架构（来自 ia 报告，如已跑）
## 4. 设计令牌（来自 visual 报告：颜色/字体/间距/圆角/阴影）
## 5. 视觉风格与氛围（来自 visual 报告）
## 6. 动效与微交互（来自 visual + interaction 报告）
## 7. 交互规范（来自 interaction 报告，如已跑）
## 8. 内容与文案规范（来自 content 报告，如已跑）
## 9. 实现优先级与风险
```

### 3.3 冲突处理

如果有冲突，用 `ask_user_question` 让用户决策。

---

## 阶段 4：HTML 原型（可选，必须二次确认）

⚠️ **消耗大量 token，必须先问用户。**

用 `ask_user_question` 弹窗：

> **「是否生成 HTML 原型？」**
> 1. 生成完整 HTML 原型 —— 消耗较多 token
> 2. 仅生成 1 个关键页面的原型（推荐）
> 3. 仅保留规范文档，不生成原型
> 4. 跳过

如果用户选 1 或 2：
1. 读 `~/.pi/agent/skills/design-dna/SKILL.md` 了解 Generate 阶段
2. 读 `~/.pi/agent/skills/design-dna/references/generation-guide.md`
3. 用设计规范 + visual 报告的 Design DNA JSON + 用户内容 → 生成 HTML
4. 写到 `docs/prototype/<页面名>.html`

---

## 完成汇报

工作流结束后，向用户总结：
- ✅ 已产出文件清单（路径）
- 📊 跑了哪些 Agent、核心结论
- ⚠️ 待确认问题（来自 need 报告）
- 💰 Token 消耗概况
- 💡 下一步建议
