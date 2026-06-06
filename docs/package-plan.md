# Pi Package 化方案

> 记录时间：2026-06-06  
> 目标：判断 `pi-ui-workflow` 如何从本地模板集合升级为可安装、可分发的 Pi package。

## 当前项目资源

当前项目包含：

```text
.pi/
├── agents/
│   ├── ui-research-analyst.md
│   ├── ui-need-analyst.md
│   ├── ui-form-analyst.md
│   ├── ui-visual-analyst.md
│   ├── ui-ia-analyst.md
│   ├── ui-interaction-analyst.md
│   └── ui-content-analyst.md
└── prompts/
    ├── ui-workflow.md
    ├── ui-align.md
    └── ui-review.md
```

## Pi package 官方支持情况

根据 Pi 文档，标准 package manifest 支持：

- `extensions`
- `skills`
- `prompts`
- `themes`

目前文档没有明确说明 `agents` 可以作为 package manifest 的一等资源类型分发。

这意味着：

- `prompts` 可以标准包化；
- `agents` 暂时不能确认是否能直接标准包化；
- 如果要完整一键安装，需要额外策略处理 agents。

## 可选方案

### 方案 A：半标准包化（短期推荐）

做法：

1. 增加 `package.json`，声明 prompts：

```json
{
  "name": "pi-ui-workflow",
  "keywords": ["pi-package"],
  "pi": {
    "prompts": [".pi/prompts/*.md"]
  }
}
```

2. agents 继续通过 README 或安装脚本复制到：

```text
~/.pi/agent/agents/
```

优点：

- 改动小；
- prompts 能先进入 Pi package 体系；
- 风险低。

缺点：

- 不是完整一键安装；
- agents 仍然依赖脚本或手动复制。

适合当前阶段。

---

### 方案 B：把 Agent 转成 Skills

做法：

- 将 7 个 `.pi/agents/*.md` 转成 `skills/` 下的 Agent Skills；
- prompt template 不再调用 `subagent` agent，而是触发/引用对应 skill。

优点：

- skills 是 Pi package 官方支持资源；
- 更适合 npm / git 分发。

缺点：

- 需要重构当前 subagent 编排方式；
- 7 个“专业子 Agent”会变成“专业技能”，产品概念要重新整理；
- 当前工作流的 parallel subagent 模式可能要调整。

适合后续大版本。

---

### 方案 C：做一个 Extension 封装工作流

做法：

- 编写 Pi extension；
- 通过 extension 注册命令或工具；
- extension 内部管理 agents/prompts/进度条/安装检查。

优点：

- 最产品化；
- 有机会实现真正动态进度、TUI 面板、状态栏；
- 可控性最好。

缺点：

- 工程量最大；
- 需要写 TypeScript extension；
- 不适合当前 MVP 阶段。

适合 V3 或正式产品化版本。

---

## 当前建议

短期采用 **方案 A：半标准包化**：

1. 新增 `package.json`；
2. 声明 prompts 为 Pi package 资源；
3. 保留 `scripts/check-install.sh`；
4. 后续可新增 `scripts/install.sh` 自动复制 agents/prompts；
5. README 明确说明：当前 package 化重点覆盖 prompts，agents 仍需脚本安装。

中长期再评估：

- 如果 Pi 后续支持 agents 作为 package manifest 资源，则直接升级 manifest；
- 如果不支持，则考虑方案 B 或 C。

## 风险与待确认

1. **agents 是否可以通过未文档化 manifest 字段分发**
   - 目前不建议依赖未确认能力。

2. **npm 发布前需要补充内容**
   - `package.json`
   - `CHANGELOG.md`
   - 版本号
   - license / repository / files 字段
   - 发布前安全审查

3. **安装体验仍需脚本补齐**
   - 当前已有 `scripts/check-install.sh`；
   - 后续可增加 `scripts/install.sh`。
