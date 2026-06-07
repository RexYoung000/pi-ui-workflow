---
description: 仅执行 UI 工作流的阶段 0 + 1.5 + 2 + 3 + 4 —— 选择模式 + 搜素材 + 专家分析 + 总审核 + 可选 HTML 原型。前提是已经做过需求对齐。
---

# UI 工作流 —— 审核模式

跑**阶段 0（选择执行模式）+ 阶段 1.5（搜索素材与选择额外分析）+ 阶段 2（专家分析）+ 阶段 3（总审核）+ 阶段 4（可选 HTML 原型）**。

## 前置检查

1. 用 `read` 检查项目里是否有 `docs/ui-need-summary.md`（之前跑过 `/ui-align` 或 `/ui-workflow` 阶段 1 产生的）。
2. 检查 `README.md`、`AGENTS.md`、`package.json` 了解项目背景。
3. 如果**没有需求摘要**：提示用户先跑 `/ui-align` 或 `/ui-workflow`。
4. 继续执行前，创建本次工作流产物目录：`docs/ui-workflow/`，所有中间报告都保存到这里，方便追溯、复跑和调试。

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

如果 `docs/ui-workflow/00-need-summary.md` 不存在，把 `docs/ui-need-summary.md` 的内容复制/写入该归档文件。

---

## 阶段 0：选择执行模式

**目标**：让用户在继续分析前确认“速度 / 成本 / 质量”的取舍。

用 `ask_user_question` 让用户选择执行模式。为了避免工具参数过长，选项请使用短 label，把详细说明放到 description：

- label: `标准模式（推荐）`；description: `约 5-8 分钟，适合大多数正式 UI 设计；两段式分析，质量和速度平衡。`
- label: `快速模式`；description: `约 2-4 分钟，适合先看方向；Agent 尽量并行，输出简版设计规范，token 成本低。`
- label: `深度模式`；description: `约 8-15 分钟，适合重要产品/关键页面；更完整搜索和更严格报告传递，输出最完整。`

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
[阶段 1/5] ✅ 执行模式已确认：标准模式（预计 5-8 分钟）
[阶段 2/5] 🔍 正在搜索参考素材：用于让设计方向更有依据...
[阶段 3/5] 🧠 正在运行专家分析：form + visual 会先给下游专家打基础...
[阶段 4/5] 🧩 正在整合报告：我会检查形态、视觉、交互、内容之间是否冲突...
[阶段 5/5] ✅ 已完成：最终规范已保存，接下来可选择是否生成 HTML 原型。
```

---

## 阶段 1.5：搜索素材 + 选择额外分析 + 调用研究员

**目标**：先决定素材搜索方式，再决定额外分析范围，最后把素材交给研究员分析。

开始阶段 1.5 前，先给用户进度提示：

```text
[阶段 2/5] 🔍 正在准备参考素材：搜索结果会帮助研究员提炼更可靠的设计方向。
```

### 1.5a：弹窗选择搜索方式

用 `ask_user_question` 弹窗。选项使用短 label，详细说明放 description：

- label: `TinyFish 搜索（推荐）`；description: `搜索全网 + 浏览内置参考网站，适合大多数情况。`
- label: `自定义搜索 API`；description: `用户提供 endpoint 和 key，用 curl 调用；适合已有搜索服务。`
- label: `跳过搜索`；description: `不搜素材，研究员基于已有描述分析；更快但参考依据更少。`

问题文案中说明会优先浏览：godly.website / awwwards.com / mobbin.com / reactbits.dev / supahero.io / 60fps.design / ui-pocket.com / pinterest。

### 1.5b：弹窗选择额外分析

用 `ask_user_question` 弹一个多选。选项使用短 label，详细说明放 description：

- label: `信息架构`；description: `分析导航结构、页面层级、跳转关系和搜索体验。`
- label: `交互体验`；description: `分析微交互、状态过渡、手势、快捷键和可访问性。`
- label: `内容策略`；description: `分析界面文案、空状态、错误提示、CTA 和品牌语调。`

建议用户默认全选；如果想省时间，可以取消部分分析。

### 1.5c：执行搜索

**选 A（TinyFish）**：
1. `tinyfish_fetch` 抓取内置网站（godly.website / awwwards.com / mobbin.com / reactbits.dev / supahero.io / 60fps.design / ui-pocket.com / pinterest）
2. `tinyfish_search` 搜相关设计参考

**选 B（自定义 API）**：
- 用户输入 endpoint + key → bash curl 调用 + tinyfish_fetch 抓内置网站

**选 C（跳过）**：不搜。

**搜索失败兜底**：如果部分内置网站抓取失败、返回内容过少或需要登录，不要中断流程；记录失败来源，继续使用已获取素材和 `tinyfish_search` 结果。最终报告里说明“部分参考来源抓取失败，分析基于可用素材”。

### 1.5d：调用研究员

用 `subagent` 工具 **single 模式**：

```json
{
  "agent": "ui-research-analyst",
  "task": "<需求摘要 + 搜索结果 + 网站内容>",
  "agentScope": "user"
}
```

研究员返回后，立即用 `write` 保存到：

```text
docs/ui-workflow/01-research-report.md
```

然后给用户一条进度反馈：

```text
[阶段 2/5] ✅ 参考素材分析已完成，已保存到 docs/ui-workflow/01-research-report.md。
下一步：运行需求分析师，形成给所有专家使用的权威需求报告。
```

---



**Agent 缺失兜底**：如果 subagent 提示找不到对应 Agent，不要继续硬跑。请提示用户先在项目根目录执行：

```bash
scripts/check-install.sh
```

或把 `.pi/agents/*.md` 复制到 `~/.pi/agent/agents/` 后在 Pi 中运行 `/reload`。

---

## 阶段 2：专家分析

开始阶段 2 前，先给用户进度提示：

```text
[阶段 3/5] 🧠 正在进入专家分析：我会先生成需求报告，再按所选模式编排各专家。
```

### 阶段 2a：需求分析（单个）

用 `subagent` 工具 **single 模式**调用 `ui-need-analyst`：

```json
{
  "agent": "ui-need-analyst",
  "task": "<需求摘要全文 + 项目背景>",
  "agentScope": "user"
}
```

需求分析师返回后，立即用 `write` 保存到：

```text
docs/ui-workflow/02-need-report.md
```

然后给用户一条进度反馈：

```text
[阶段 3/5] ✅ 需求分析报告已完成，已保存到 docs/ui-workflow/02-need-report.md。
下一步：按执行模式运行形态、视觉和可选专家。
```

### 阶段 2b：按执行模式编排专家分析

根据阶段 0 的执行模式决定 Agent 编排方式：

- **快速模式**：form / visual / 可选专家尽量并行。每个 task 至少包含执行模式 + need + research，并要求 Agent 标注缺少上游报告时的假设和风险。
- **标准模式（推荐）**：第一段并行跑 form + visual；第二段把 need + research + form + visual 传给用户勾选的可选专家。
- **深度模式**：按 form → visual → ia → interaction → content 严格传递上游报告，追求最高一致性。

#### 快速模式

执行前先提示用户：

```text
[阶段 3/5] ⚡ 快速模式：即将并行运行专家，优先缩短等待时间；部分专家会基于假设输出，并在报告里标注风险。
```

用 `subagent` 工具 **parallel 模式**，每个 task 包含 need 完整报告 + research 完整报告，并说明当前是快速模式：

```json
{
  "tasks": [
    { "agent": "ui-form-analyst", "task": "## 执行模式\n快速模式：请基于 need + research 快速给出形态建议，并标注关键假设。\n\n## 需求报告\n<need 报告>\n\n## 参考素材报告\n<research 报告>" },
    { "agent": "ui-visual-analyst", "task": "## 执行模式\n快速模式：请基于 need + research 快速给出视觉规范。如缺少形态报告，请说明假设。\n\n## 需求报告\n<need 报告>\n\n## 参考素材报告\n<research 报告>" }
    // + 用户勾选的可选 agent；可选专家也必须说明快速模式下可能缺少 form/visual 上游报告。
  ],
  "agentScope": "user"
}
```

#### 标准模式（推荐）

执行前先提示用户：

```text
[阶段 3/5] 🧩 标准模式：先运行形态 + 视觉专家，为后续信息架构、交互和内容专家提供稳定基础。
```

第一段：并行跑 form + visual。

```json
{
  "tasks": [
    { "agent": "ui-form-analyst", "task": "## 执行模式\n标准模式：请给出可供下游专家使用的完整形态报告。\n\n## 需求报告\n<need 报告>\n\n## 参考素材报告\n<research 报告>" },
    { "agent": "ui-visual-analyst", "task": "## 执行模式\n标准模式：请给出可供下游专家使用的完整视觉规范。\n\n## 需求报告\n<need 报告>\n\n## 参考素材报告\n<research 报告>" }
  ],
  "agentScope": "user"
}
```

第二段：按用户勾选加入 `ui-ia-analyst` / `ui-interaction-analyst` / `ui-content-analyst`，并把 need + research + form + visual 都传进去。

#### 深度模式

执行前先提示用户：

```text
[阶段 3/5] 🧠 深度模式：我会按上游依赖逐个传递报告，等待更久，但最终一致性最高。
```

用 `subagent` 工具 **single 模式**逐步调用，后一个 Agent 必须拿到前面所有关键报告：

1. `ui-form-analyst`：输入 need + research。
2. `ui-visual-analyst`：输入 need + research + form。
3. `ui-ia-analyst`（如勾选）：输入 need + research + form + visual。
4. `ui-interaction-analyst`（如勾选）：输入 need + research + form + visual + ia（如有）。
5. `ui-content-analyst`（如勾选）：输入 need + research + form + visual + ia + interaction（如有）。

每一步完成后都要给用户一条等待反馈，降低黑盒等待感。

所有专家报告返回后，必须立即保存到对应归档路径：

```text
ui-form-analyst        → docs/ui-workflow/03-form-report.md
ui-visual-analyst      → docs/ui-workflow/04-visual-report.md
ui-ia-analyst          → docs/ui-workflow/05-ia-report.md
ui-interaction-analyst → docs/ui-workflow/06-interaction-report.md
ui-content-analyst     → docs/ui-workflow/07-content-report.md
```

保存后给用户一条进度反馈，例如：

```text
✅ 视觉报告已完成，已保存到 docs/ui-workflow/04-visual-report.md
```

---

## 阶段 3：总审核

开始阶段 3 前，先给用户进度提示：

```text
[阶段 4/5] 🧩 正在整合专家报告：我会检查需求、形态、视觉、交互、内容之间是否冲突。
```

1. 检测所有报告之间的冲突
2. 整合为两个位置：
   - `docs/ui-design-spec.md`：最终规范，方便用户直接查看
   - `docs/ui-workflow/99-ui-design-spec.md`：本次工作流归档
3. 有冲突用 `ask_user_question` 让用户决策

完成总审核后，给用户进度提示：

```text
[阶段 4/5] ✅ 设计规范已完成，已保存到 docs/ui-design-spec.md 和 docs/ui-workflow/99-ui-design-spec.md。
下一步：确认是否需要生成 HTML 原型。
```

---

## 阶段 4：HTML 原型（必须二次确认）

开始阶段 4 前，先给用户进度提示：

```text
[阶段 5/5] 🧪 设计规范已就绪：现在可以选择是否生成 HTML 原型。
```

用 `ask_user_question`。选项使用短 label，详细说明放 description：

- label: `关键页面原型（推荐）`；description: `只生成 1 个关键页面，先看效果，token 成本较可控。`
- label: `完整原型`；description: `生成完整 HTML 原型，效果更完整，但消耗更多 token。`
- label: `仅保留规范`；description: `不生成 HTML，只保留设计规范文档。`
- label: `跳过`；description: `不做额外动作。`

如果用户选 1 或 2：读 design-dna SKILL.md → generation-guide.md → 生成 HTML → 写入 `docs/prototype/`

---

## 完成汇报

- ✅ 产出文件清单（路径），必须包含 `docs/ui-workflow/` 下的中间报告归档
- 📊 跑了哪些 Agent、核心结论
- ⚠️ 待确认问题
- 💡 下一步建议
