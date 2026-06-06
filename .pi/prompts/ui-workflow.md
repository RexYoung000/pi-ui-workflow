---
description: UI 工作流完整流程 —— 选择模式 → 对齐需求 → 搜索素材 → 专家分析 → 总审核 → 可选 HTML 原型
argument-hint: "[产品/功能的简要描述]"
---

# UI 工作流（完整版）

你现在是 UI 工作流的**总审核人**。你要严格按下面的阶段执行，每个阶段清晰汇报进度。**用户输入的描述是：$@**

---

## 阶段 0：选择执行模式

**目标**：在正式执行前，把“等待时间、token 成本、输出质量”的取舍交给用户。

用 `ask_user_question` 让用户选择执行模式：

> **「这次 UI 工作流要用哪种执行模式？」**
>
> A. **快速模式**（约 2-4 分钟）—— 更适合先看方向，Agent 尽量并行，输出简版设计规范，token 成本低
> B. **标准模式（推荐）**（约 5-8 分钟）—— 适合大多数正式 UI 设计，采用两段式分析，质量和速度平衡
> C. **深度模式**（约 8-15 分钟）—— 适合重要产品/关键页面，更完整搜索和更严格的报告传递，输出最完整，token 成本高

选择后，在后续执行中始终遵守对应编排：

| 模式 | Agent 编排 | 搜索强度 | 输出质量 | 适用场景 |
|------|------------|----------|----------|----------|
| 快速模式 | need / research 后，form + visual + 可选专家尽量并行 | 可跳过或轻量搜索 | 中 | 快速探索方向、早期想法验证 |
| 标准模式（推荐） | research → need → form + visual → 可选专家 → 总审核 | 标准搜索 | 高 | 大多数 UI 设计任务 |
| 深度模式 | research → need → form → visual → ia → interaction → content → 总审核 | 更充分搜索 | 最高 | 正式产品、关键页面、准备进入开发 |

执行过程中必须用文字型进度反馈降低等待感：

- 每个阶段开始前：告诉用户“正在做什么 + 为什么做 + 预计产出”。
- 每个阶段完成后：告诉用户“完成了什么 + 保存在哪里 + 下一步是什么”。
- 并行 Agent 执行前：告诉用户“本轮会同时跑哪些 Agent + 为什么可以并行”。
- 串行/两段式执行前：告诉用户“为什么要等上一步完成 + 这会提升什么质量”。
- 遇到跳过搜索、跳过可选专家等情况：明确说明“省了什么时间 / 少了什么信息”。

推荐使用下面的进度格式：

```text
[阶段 1/6] ✅ 执行模式已确认：标准模式（预计 5-8 分钟）
[阶段 2/6] 🔎 正在对齐需求：我会先确认产品目标、用户和关键页面...
[阶段 3/6] 🔍 正在搜索参考素材：用于让设计方向更有依据...
[阶段 4/6] 🧠 正在运行专家分析：form + visual 会先给下游专家打基础...
[阶段 5/6] 🧩 正在整合报告：我会检查形态、视觉、交互、内容之间是否冲突...
[阶段 6/6] ✅ 已完成：最终规范已保存，接下来可选择是否生成 HTML 原型。
```

---

## 阶段 1：对齐需求

**目标**：在调用任何子 Agent 之前，理解用户要做什么。

开始阶段 1 前，先给用户进度提示：

```text
[阶段 2/6] 🔎 正在对齐需求：我会确认产品目标、目标用户、关键页面和主要约束。
```

运行开始时先创建本次工作流产物目录：`docs/ui-workflow/`。所有中间报告都要保存到这个目录，方便追溯、复跑和调试。

推荐归档路径：

```text
docs/ui-workflow/
├── 00-need-summary.md
├── 01-research-report.md
├── 02-need-report.md
├── 03-form-report.md
├── 04-visual-report.md
├── 05-ia-report.md
├── 06-interaction-report.md
├── 07-content-report.md
└── 99-ui-design-spec.md
```

1. 用 `read` / `ls` / `find` 检查项目里是否已有 `README.md`、`AGENTS.md`、`docs/`、`package.json`、已有 UI 代码等。
2. 如果信息足够，用 `ask_user_question` 确认 2-3 个关键方向（每问最多 4 个问题）。常见关键决策：
   - 产品形态（Web / 移动 / 桌面 / 多端）
   - 目标用户（专业用户 / 大众 / 企业内部）
   - 风格调性（专业克制 / 活泼现代 / 极简优雅 / 奢华精致）
   - MVP 范围
3. 如果信息严重不足，分两轮问，**不要一次堆太多问题**。
4. 用一段中文总结「我理解的需求」，让用户确认。

### 1.1 保存需求摘要

用 `write` 把阶段 1 对齐的结果保存到两个位置：

- `docs/ui-need-summary.md`：兼容旧流程和 `/ui-review` 前置检查
- `docs/ui-workflow/00-need-summary.md`：本次工作流归档

保存后给用户进度提示：

```text
[阶段 2/6] ✅ 需求摘要已完成，已保存到 docs/ui-need-summary.md 和 docs/ui-workflow/00-need-summary.md。
下一步：选择搜索方式和额外分析范围。
```

```markdown
# UI 需求摘要
- **执行模式**：<快速模式 / 标准模式 / 深度模式>
- **产品定位**：<一句话>
- **目标用户**：<谁>
- **核心功能（P0/P1/P2）**：
- **关键页面**：
- **约束与偏好**：<技术栈 / 平台 / 品牌调性 / 参考产品>
- **待确认问题**：<如果有>
```

---

## 阶段 1.5：搜索素材 + 选择额外分析 + 调用研究员

**目标**：先决定素材搜索方式，再决定额外分析范围，最后把素材交给研究员分析。

开始阶段 1.5 前，先给用户进度提示：

```text
[阶段 3/6] 🔍 正在准备参考素材：搜索结果会帮助研究员提炼更可靠的设计方向。
```

### 1.5a：弹窗选择搜索方式

用 `ask_user_question` 弹窗：

> **「选择搜索方式，我会优先浏览以下网站找参考：godly.website / awwwards.com / mobbin.com / reactbits.dev / supahero.io / 60fps.design / ui-pocket.com / pinterest」**
>
> A. **TinyFish 搜索**（推荐，免费，已装好）—— 搜索全网 + 浏览内置网站
> B. **自定义搜索 API** —— 请输入 API endpoint 和 key
> C. **跳过搜索** —— 不搜素材，研究员基于已有描述直接分析

### 1.5b：弹窗选择额外分析

用 `ask_user_question` 弹一个多选：

> **基础分析（需求/形态/视觉/素材）会自动跑。还需要以下额外分析吗？**
> - ☑ 信息架构分析（导航结构、页面层级、跳转关系）
> - ☑ 交互体验分析（微交互、状态过渡、手势、可访问性）
> - ☑ 内容策略分析（界面文案、提示语、CTA 语调）
> 默认全勾，用户可取消。

把用户选择记录到后续 task 里；如需要，也可以补写到 `docs/ui-need-summary.md`。

### 1.5c：执行搜索

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

### 1.5d：调用研究员

用 `subagent` 工具的 **single 模式**调用 `ui-research-analyst`：

```json
{
  "agent": "ui-research-analyst",
  "task": "<需求摘要 + 搜索到的素材内容 + 内置网站的抓取结果>",
  "agentScope": "user"
}
```

**重要**：task 里要把搜到的素材内容尽量详细地写进去。研究员看不到你的对话，只能看到这个 task。如果选了"跳过搜索"，也要在 task 里说明情况。

研究员返回后，立即用 `write` 保存到：

```text
docs/ui-workflow/01-research-report.md
```

然后给用户一条进度反馈：

```text
[阶段 3/6] ✅ 参考素材分析已完成，已保存到 docs/ui-workflow/01-research-report.md。
下一步：运行需求分析师，形成给所有专家使用的权威需求报告。
```

---

## 阶段 2：专家分析

开始阶段 2 前，先给用户进度提示：

```text
[阶段 4/6] 🧠 正在进入专家分析：我会先生成需求报告，再按所选模式编排各专家。
```

### 阶段 2a：需求分析（单个）

用 `subagent` 工具 **single 模式**调用 `ui-need-analyst`：

```json
{
  "agent": "ui-need-analyst",
  "task": "<阶段 1 确认的需求摘要 + 项目背景 + 用户原始描述>",
  "agentScope": "user"
}
```

需求分析师产出完整的需求报告，这份报告是阶段 2b 所有专家的权威输入。

需求分析师返回后，立即用 `write` 保存到：

```text
docs/ui-workflow/02-need-report.md
```

然后给用户一条进度反馈：

```text
[阶段 4/6] ✅ 需求分析报告已完成，已保存到 docs/ui-workflow/02-need-report.md。
下一步：按执行模式运行形态、视觉和可选专家。
```

### 阶段 2b：按执行模式编排专家分析

根据阶段 0 的执行模式决定 Agent 编排方式。核心原则：

- **快速模式**：优先减少等待时间，允许 form / visual / 可选专家尽量并行，但每个 task 都必须明确说明“当前是快速模式，可能缺少上游报告，需基于 need + research 做合理假设，并把假设写入风险”。
- **标准模式（推荐）**：先跑 form + visual，再把 form / visual 报告传给可选专家，平衡速度和一致性。
- **深度模式**：严格传递上游报告，按 form → visual → ia → interaction → content 的顺序或半串行方式执行，追求最终规范一致性。

#### 快速模式：专家尽量并行

适合先快速看方向。执行前先提示用户：

```text
[阶段 4/6] ⚡ 快速模式：即将并行运行专家，优先缩短等待时间；部分专家会基于假设输出，并在报告里标注风险。
```

用 `subagent` 工具 **parallel 模式**，每个 task 至少包含：执行模式 + need 完整报告 + research 完整报告。

```json
{
  "tasks": [
    {
      "agent": "ui-form-analyst",
      "task": "## 执行模式\n快速模式：请基于 need + research 快速给出形态建议，并标注关键假设。\n\n## 需求报告\n<need 完整报告>\n\n## 参考素材报告\n<research 完整报告>"
    },
    {
      "agent": "ui-visual-analyst",
      "task": "## 执行模式\n快速模式：请基于 need + research 快速给出视觉规范。如缺少形态报告，请说明假设。\n\n## 需求报告\n<need 完整报告>\n\n## 参考素材报告\n<research 完整报告>"
    }
    // 按用户勾选加入 ia / interaction / content；这些 task 也必须说明“快速模式下可能缺少 form/visual 上游报告”。
  ],
  "agentScope": "user"
}
```

#### 标准模式（推荐）：两段式分析

适合大多数正式 UI 设计。执行前先提示用户：

```text
[阶段 4/6] 🧩 标准模式：先运行形态 + 视觉专家，为后续信息架构、交互和内容专家提供稳定基础。
```

第一段并行跑 form + visual；第二段把 form / visual 报告传给可选专家。

第一段：

```json
{
  "tasks": [
    {
      "agent": "ui-form-analyst",
      "task": "## 执行模式\n标准模式：请给出可供下游专家使用的完整形态报告。\n\n## 需求报告\n<need 完整报告>\n\n## 参考素材报告\n<research 完整报告>"
    },
    {
      "agent": "ui-visual-analyst",
      "task": "## 执行模式\n标准模式：请给出可供下游专家使用的完整视觉规范。\n\n## 需求报告\n<need 完整报告>\n\n## 参考素材报告\n<research 完整报告>"
    }
  ],
  "agentScope": "user"
}
```

第二段：按用户勾选的可选专家并行执行，每个 task 必须包含 need + research + form + visual：

```json
{
  "tasks": [
    {
      "agent": "ui-ia-analyst",
      "task": "## 执行模式\n标准模式：请基于完整上游报告给出信息架构。\n\n## 需求报告\n<need 完整报告>\n\n## 参考素材报告\n<research 完整报告>\n\n## 形态报告\n<form 完整报告>\n\n## 视觉报告\n<visual 完整报告>"
    },
    {
      "agent": "ui-interaction-analyst",
      "task": "## 执行模式\n标准模式：请基于形态和视觉报告给出交互体验方案。\n\n## 需求报告\n<need 完整报告>\n\n## 参考素材报告\n<research 完整报告>\n\n## 形态报告\n<form 完整报告>\n\n## 视觉报告\n<visual 完整报告>"
    },
    {
      "agent": "ui-content-analyst",
      "task": "## 执行模式\n标准模式：请基于页面形态和品牌调性给出内容策略。\n\n## 需求报告\n<need 完整报告>\n\n## 参考素材报告\n<research 完整报告>\n\n## 形态报告\n<form 完整报告>\n\n## 视觉报告\n<visual 完整报告>"
    }
  ],
  "agentScope": "user"
}
```

#### 深度模式：严格传递上游报告

适合重要产品或关键页面。执行前先提示用户：

```text
[阶段 4/6] 🧠 深度模式：我会按上游依赖逐个传递报告，等待更久，但最终一致性最高。
```

按顺序逐步执行，后一个 Agent 必须拿到前面所有关键报告：

1. `ui-form-analyst`：输入 need + research。
2. `ui-visual-analyst`：输入 need + research + form。
3. `ui-ia-analyst`（如勾选）：输入 need + research + form + visual。
4. `ui-interaction-analyst`（如勾选）：输入 need + research + form + visual + ia（如有）。
5. `ui-content-analyst`（如勾选）：输入 need + research + form + visual + ia + interaction（如有）。

深度模式可以使用 `subagent` 的 single 模式逐个调用，或在不破坏上游依赖的前提下做小范围并行。每一步完成后都要给用户一条等待反馈，例如：

```text
✅ 形态报告已完成，正在交给视觉分析师生成 Design Tokens...
✅ 视觉报告已完成，正在交给交互/内容专家细化体验...
```

**关键提示**：
- 可选的 agent 只加入用户勾选的那些。
- 每个子 Agent 看不到之前对话，task 里必须粘贴它需要的完整上游报告。
- 每个子 Agent 返回后，必须立即保存到对应归档路径：
  - `ui-form-analyst` → `docs/ui-workflow/03-form-report.md`
  - `ui-visual-analyst` → `docs/ui-workflow/04-visual-report.md`
  - `ui-ia-analyst` → `docs/ui-workflow/05-ia-report.md`
  - `ui-interaction-analyst` → `docs/ui-workflow/06-interaction-report.md`
  - `ui-content-analyst` → `docs/ui-workflow/07-content-report.md`
- 保存后给用户一条进度反馈，例如：`✅ 视觉报告已完成，已保存到 docs/ui-workflow/04-visual-report.md`。
- 如果某个模式为了速度省略了上游报告，必须让对应 Agent 在报告中写明假设和风险。
- 默认使用 `agentScope: "user"`，只调用用户全局安装的可信 Agent。
- 如果用户明确使用可信项目本地 `.pi/agents`，可改用 `agentScope: "both"`，但不要设置 `confirmProjectAgents: false`，保留 Pi 的项目 Agent 安全确认。

---

## 阶段 3：总审核

**目标**：整合所有报告，产出一份最终的设计规范。

开始阶段 3 前，先给用户进度提示：

```text
[阶段 5/6] 🧩 正在整合专家报告：我会检查需求、形态、视觉、交互、内容之间是否冲突。
```

### 3.1 检测冲突

对比所有报告，找出不一致的地方。常见冲突：
- need 说"移动优先"，但 form 的断点策略没体现
- form 推荐了暗色主题库，但 visual 给的是亮色
- ia 给了 4 级深导航，但 interaction 建议键盘快捷键操作
- content 的风格是"亲切活泼"，但 visual 的配色是银行级的深蓝
- 等等

### 3.2 整合最终文档

用 `write` 写到两个位置：

- `docs/ui-design-spec.md`：兼容旧流程和用户最容易找到的最终规范
- `docs/ui-workflow/99-ui-design-spec.md`：本次工作流归档

结构：

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

完成总审核后，给用户进度提示：

```text
[阶段 5/6] ✅ 设计规范已完成，已保存到 docs/ui-design-spec.md 和 docs/ui-workflow/99-ui-design-spec.md。
下一步：确认是否需要生成 HTML 原型。
```

---

## 阶段 4：HTML 原型（可选，必须二次确认）

⚠️ **消耗大量 token，必须先问用户。**

开始阶段 4 前，先给用户进度提示：

```text
[阶段 6/6] 🧪 设计规范已就绪：现在可以选择是否生成 HTML 原型。
```

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
- ✅ 产出文件清单（路径），必须包含 `docs/ui-workflow/` 下的中间报告归档
- 📊 跑了哪些 Agent、核心结论
- ⚠️ 待确认问题（来自 need 报告）
- 💰 Token 消耗概况
- 💡 下一步建议
