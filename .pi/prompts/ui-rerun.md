---
description: 基于 docs/ui-workflow/ 中已有报告，局部重跑 UI 工作流的某一部分，例如视觉、交互、内容、搜索或最终规范。
argument-hint: "[要重跑的部分]"
---

# UI 工作流 —— 局部复跑

你现在是 UI 工作流的**局部复跑协调人**。用户想基于已有中间报告，只重跑某一部分，避免完整流程重复消耗时间和 token。用户输入是：$@

---

## 阶段 0：检查已有报告

先用 `read` / `ls` 检查：

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

如果 `docs/ui-workflow/` 不存在，提示用户先运行 `/ui-workflow` 或 `/ui-review`。

---

## 阶段 1：选择局部复跑范围

用 `ask_user_question` 让用户选择要重跑的部分：

> **「这次要局部重跑哪一部分？」**
>
> A. **重跑视觉** —— 基于 need + research + form，重新生成视觉规范和 design tokens
> B. **重跑交互** —— 基于 need + research + form + visual，重新生成交互体验方案
> C. **重跑内容** —— 基于 need + research + form + visual，重新生成文案和内容策略
> D. **重整最终规范** —— 不调用子 Agent，只基于现有报告重新整合 `ui-design-spec.md`

如果用户输入明确指定了范围（例如“只重跑视觉”），可以直接执行对应分支。

---

## 阶段 2：执行对应分支

### A. 重跑视觉

需要读取：

- `docs/ui-workflow/02-need-report.md`
- `docs/ui-workflow/01-research-report.md`
- `docs/ui-workflow/03-form-report.md`（如存在）

调用 `ui-visual-analyst`，task 必须说明：

```text
这是局部复跑：只重跑视觉报告。请基于已有上游报告重新生成视觉规范。
```

完成后覆盖写入：

```text
docs/ui-workflow/04-visual-report.md
```

然后询问是否重新整合最终规范。

### B. 重跑交互

需要读取：

- `docs/ui-workflow/02-need-report.md`
- `docs/ui-workflow/01-research-report.md`
- `docs/ui-workflow/03-form-report.md`
- `docs/ui-workflow/04-visual-report.md`
- `docs/ui-workflow/05-ia-report.md`（如存在）

调用 `ui-interaction-analyst`。

完成后覆盖写入：

```text
docs/ui-workflow/06-interaction-report.md
```

然后询问是否重新整合最终规范。

### C. 重跑内容

需要读取：

- `docs/ui-workflow/02-need-report.md`
- `docs/ui-workflow/01-research-report.md`
- `docs/ui-workflow/03-form-report.md`
- `docs/ui-workflow/04-visual-report.md`
- `docs/ui-workflow/06-interaction-report.md`（如存在）

调用 `ui-content-analyst`。

完成后覆盖写入：

```text
docs/ui-workflow/07-content-report.md
```

然后询问是否重新整合最终规范。

### D. 重整最终规范

不调用子 Agent。读取 `docs/ui-workflow/` 中已有报告，重新整合：

```text
docs/ui-design-spec.md
docs/ui-workflow/99-ui-design-spec.md
```

---

## 阶段 3：等待反馈

执行过程中用文字型进度反馈：

```text
[局部复跑 1/3] 🔎 正在检查已有报告...
[局部复跑 2/3] 🎯 正在重跑视觉报告...
[局部复跑 3/3] ✅ 已保存到 docs/ui-workflow/04-visual-report.md
```

---

## 完成汇报

告诉用户：

- 重跑了哪一部分；
- 读取了哪些上游报告；
- 覆盖写入了哪些文件；
- 是否已重新整合最终规范；
- 还有哪些报告可能需要同步重跑。
