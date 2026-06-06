# 动态进度方案

> 记录时间：2026-06-06  
> 目标：判断 `pi-ui-workflow` 是否能实现真正的等待动画、进度条或 Agent 队列面板。

## 当前结论

### Prompt template 能做到什么

当前 `/ui-workflow`、`/ui-review`、`/ui-rerun` 属于 prompt template。它们适合做：

- 阶段性文字提示；
- 当前阶段说明；
- 完成后路径说明；
- 已完成 / 正在做 / 下一步的 checklist；
- 不同模式下的等待预期说明。

这就是当前已经实现的文字型等待反馈。

### Prompt template 做不到或不稳定的事情

仅靠 prompt template 不适合实现：

- 真正实时刷新动画；
- 状态栏持续更新；
- TUI 进度条；
- 可交互的 Agent 队列面板；
- 后台任务状态监听；
- 精确百分比进度。

原因是 prompt template 本质是一次性展开的指令，不能持续控制 Pi TUI 的渲染状态。

## Extension 方案

如果要做真正动态进度，建议做 Pi extension。

Pi extension 支持：

- `ctx.ui.setStatus()`：更新底部状态；
- `ctx.ui.setWidget()`：在编辑器上方展示自定义文本块；
- `ctx.ui.notify()`：弹出通知；
- `ctx.ui.custom()`：构建更复杂的 TUI 组件；
- `pi.registerCommand()`：注册自定义命令；
- 监听 tool call / session events，做进度状态更新。

## 可行产品形态

### V1：文字型进度（已实现）

示例：

```text
[阶段 4/6] 🧠 正在运行专家分析：form + visual 会先给下游专家打基础...
```

优点：

- 无需写代码；
- 立即可用；
- 风险低。

缺点：

- 不是真正动态刷新；
- 不能显示实时队列状态。

### V2：状态栏进度

用 extension 在底部显示：

```text
UI Workflow: 阶段 4/6 · 正在运行 visual analyst
```

适合最小 extension 化。

### V3：Agent 队列面板

用 `ctx.ui.setWidget()` 或 `ctx.ui.custom()` 显示：

```text
UI Workflow Progress
✅ 需求摘要
✅ 参考素材分析
✅ 需求分析
⏳ 形态分析
⏳ 视觉分析
○ 信息架构
○ 交互体验
○ 内容策略
○ 总审核
```

适合正式产品化版本。

### V4：自定义命令 + 进度管理器

注册命令：

```text
/ui-workflow-pro
```

由 extension 管理：

- 模式选择；
- Agent 队列；
- 状态栏；
- 报告路径；
- 错误恢复；
- 局部复跑。

这是最完整但工程量最大的方向。

## 建议路线

当前阶段不建议立刻做 extension。

推荐路线：

1. **现在**：保留 prompt template + 文字型进度；
2. **下一阶段**：如果用户频繁使用，先做轻量 extension，仅提供状态栏和 widget；
3. **正式产品化**：把 `/ui-workflow` 从 prompt template 升级成 extension command。

## 风险

1. 真正百分比进度很难准确，因为 LLM / subagent 耗时不可预测。
2. 更合理的是显示“阶段进度”和“Agent 队列状态”，而不是精确百分比。
3. extension 会增加安装和安全成本，需要配合 package 化方案一起设计。
