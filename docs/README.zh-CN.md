# pi-ui-workflow

一个为 [pi coding agent](https://github.com/earendil-works/pi-coding-agent) 设计的 **UI 设计工作流**。由一个总审核人（主控 AI）协调 7 个专业子 Agent（4 必选 + 3 可选），从需求、形态、视觉、信息架构、交互、内容六个角度全面分析，最终产出可执行的 UI 设计规范文档，可选生成高保真 HTML 原型。

## 30 秒开始使用

> 适合已经安装好 Pi，并且想尽快在任意项目里使用 `/ui-workflow` 的用户。

### 1. 安装插件

```bash
pi install npm:pi-ui-workflow
```

> 如果 Pi 已在运行中，安装后输入 `/reload` 重新加载扩展和 prompts。

### 2. 进入产品项目并启动 Pi

```bash
cd /path/to/your-product
pi
```

### 3. 输入工作流命令

```text
/ui-workflow 我要做一个面向独立开发者的极简时间追踪工具
```

成功后你会看到：

1. 先选择执行模式：快速 / 标准 / 深度；
2. 再确认产品需求；
3. 然后选择搜索方式和额外分析范围；
4. 最后生成 `docs/ui-design-spec.md`，并把中间报告归档到 `docs/ui-workflow/`。

### 局部复跑

如果已经跑过完整工作流，并且 `docs/ui-workflow/` 中有中间报告，可以使用：

```text
/ui-rerun 只重跑视觉
```

它会复用已有报告，只重跑指定部分，减少等待和 token 消耗。

> 本插件已内置 design-dna、所有 Agent 和子 Agent 调用引擎，安装后即可直接使用。唯一可选增强是 TinyFish 搜索（用于设计素材搜索，可跳过）。

## 这是什么

把「我要做一个 XXX 产品」这种模糊需求，自动变成：

1. **参考素材分析**（内置 8 个高质量设计网站 + 可选的 TinyFish 全网搜索）
2. **结构化需求报告**（目标用户、核心功能、关键场景）
3. **UI 形态决策**（页面类型、布局范式、组件选型、响应式策略）
4. **信息架构**（导航结构、页面层级、跳转逻辑）
5. **可量化的视觉规范**（完整设计令牌 + design-dna 调用）
6. **交互体验方案**（微交互、状态过渡、手势、可访问性）
7. **内容与文案规范**（界面文案、CTA、错误提示、品牌语调）
8. **整合后的设计规范文档**（markdown） + **（可选）高保真 HTML 原型**

## 工作流总览

工作流开始时会先让用户选择执行模式，把“等待时间、token 成本、输出质量”的取舍交给用户：

| 模式 | 预计耗时 | Agent 编排 | 输出质量 | 适用场景 |
|------|----------|------------|----------|----------|
| 快速模式 | 约 2-4 分钟 | 专家尽量并行 | 中 | 快速探索方向、早期想法验证 |
| 标准模式（推荐） | 约 5-8 分钟 | 两段式分析 | 高 | 大多数 UI 设计任务 |
| 深度模式 | 约 8-15 分钟 | 更严格串行/半串行 | 最高 | 正式产品、关键页面、准备进入开发 |

```
阶段 0：选择执行模式（主控 AI）
  ├─ 快速模式：更快，适合先看方向
  ├─ 标准模式：质量和速度平衡，默认推荐
  └─ 深度模式：更完整，适合重要产品
       ↓
阶段 1：对齐需求（主控 AI）
  ├─ 扫项目、问关键问题
  └─ 保存 docs/ui-need-summary.md
       ↓
阶段 1.5：素材搜索 + 额外分析选择（主控 AI + 研究员）
  ├─ 弹窗选搜索方式（TinyFish / 自定义 API / 跳过）
  ├─ 弹窗勾选额外分析（信息架构/交互/内容，默认全勾）
  ├─ 浏览 8 个内置参考网站
  └─ 调用 ui-research-analyst → 参考素材分析报告
       ↓
阶段 2a：需求分析
  └─ 调用 ui-need-analyst → 需求分析报告
       ↓
阶段 2b：专家分析（按执行模式编排）
  ├─ 快速模式：form / visual / 可选专家尽量并行
  ├─ 标准模式：form + visual 先跑，再跑可选专家
  └─ 深度模式：form → visual → ia → interaction → content 更严格传递
       ↓
阶段 3：总审核（主控 AI）
  ├─ 检测冲突
  ├─ 整合 docs/ui-design-spec.md
  └─ 归档 docs/ui-workflow/99-ui-design-spec.md
       ↓
阶段 4：HTML 原型（可选，必须二次确认）
  ├─ ask_user_question 询问
  └─ 调用 design-dna Generate → docs/prototype/*.html
```

执行过程中会用文字型进度反馈降低等待感。反馈会遵循“阶段编号 + 当前动作 + 为什么做 + 下一步”的格式，例如：

```text
[阶段 1/6] ✅ 执行模式已确认：标准模式（预计 5-8 分钟）
[阶段 2/6] 🔎 正在对齐需求：我会先确认产品目标、用户和关键页面...
[阶段 3/6] 🔍 正在搜索参考素材：用于让设计方向更有依据...
[阶段 4/6] 🧠 正在运行专家分析：form + visual 会先给下游专家打基础...
[阶段 5/6] 🧩 正在整合报告：我会检查形态、视觉、交互、内容之间是否冲突...
[阶段 6/6] ✅ 已完成：最终规范已保存，接下来可选择是否生成 HTML 原型。
```

工作流会保留两类产物：

- **最终产物**：`docs/ui-design-spec.md`、`docs/prototype/*.html`（如生成）
- **中间报告归档**：`docs/ui-workflow/`，包含需求摘要、参考素材报告、各专家报告和最终规范归档

推荐归档结构：

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

这些文件是每次运行生成的产物，默认已加入 `.gitignore`，避免把项目运行结果误提交到扩展仓库。

## 7 个子 Agent

| # | Agent | 性质 | 职责 | 关键上游输入 |
|---|-------|------|------|--------------|
| 1 | **ui-research-analyst** | 必选 | 分析参考素材、识别风格趋势、提炼可借鉴模式 | 需求摘要 + 搜索素材 |
| 2 | **ui-need-analyst** | 必选 | 产品定位、目标用户、核心功能、关键页面 | 需求摘要 + 项目背景 |
| 3 | **ui-form-analyst** | 必选 | 页面类型、布局范式、组件库选型、响应式策略 | need + research |
| 4 | **ui-visual-analyst** | 必选 | 配色/字体/间距/动效 + 调用 design-dna | need + research；标准/深度模式下尽量包含 form |
| 5 | **ui-ia-analyst** | 可选 | 导航结构、信息层级、页面跳转、搜索体验 | need + research + form + visual |
| 6 | **ui-interaction-analyst** | 可选 | 微交互、状态过渡、手势、可访问性 | need + research + form + visual + ia（如有） |
| 7 | **ui-content-analyst** | 可选 | 界面文案、空状态、错误提示、品牌语调 | need + research + form + visual + interaction（如有） |

## 三个工作流入口

| 命令 | 用途 |
|------|------|
| `/ui-workflow <描述>` | 完整流程：选择模式 → 对齐 → 搜索 → 分析 → 审核 → 可选原型 |
| `/ui-align` | 只跑阶段 1（对齐需求），输出需求摘要 |
| `/ui-review` | 跑阶段 0+1.5+2+3+4（跳过对齐，直接选择模式、搜索、分析和审核） |
| `/ui-rerun [范围]` | 基于 `docs/ui-workflow/` 局部复跑视觉、交互、内容或最终规范 |

### 手动安装（备选）

如果不使用 npm 安装，可以手动复制：

```bash
mkdir -p ~/.pi/agent/agents ~/.pi/agent/prompts
cp .pi/agents/*.md ~/.pi/agent/agents/
cp .pi/prompts/*.md ~/.pi/agent/prompts/
```

> 手动安装方式不会加载内置 extension，因此需要额外安装官方 `subagent` 扩展来运行工作流。

## 安全默认值

为了适合分发给其他用户，本工作流默认只调用用户全局安装的 Agent：

```json
{
  "agentScope": "user"
}
```

这样可以避免在陌生项目里自动执行项目本地 `.pi/agents`。如果你明确信任某个项目里的本地 Agent，可以在 prompt 里临时改为：

```json
{
  "agentScope": "both"
}
```

但不建议关闭项目 Agent 的安全确认，不要默认使用 `confirmProjectAgents: false`。

## Package 化状态

当前项目通过 Pi package manifest 声明了 prompts、extensions 和 skills：

```json
{
  "pi": {
    "prompts": [".pi/prompts/*.md"],
    "extensions": ["extensions/ui-workflow"],
    "skills": ["skills/design-dna"]
  }
}
```

内置 extension 会自动从 package 内部 `.pi/agents/` 加载 7 个 UI 子 Agent，**无需手动复制**。详细方案文档：

- `docs/package-plan.md`：Pi package 化路线
- `docs/progress-plan.md`：动态进度 / TUI 面板后续方案

## 内置参考网站

素材搜索时，无论选什么方式，都会优先浏览以下 8 个高质量设计参考站：

- **godly.website** —— 极高质量网页设计集合
- **awwwards.com** —— 网页设计奖项与趋势
- **mobbin.com** —— 移动端真实产品截图
- **reactbits.dev/components/magic-bento** —— React 组件示例
- **supahero.io** —— 设计灵感集合
- **60fps.design** —— 高质量 UI 动画参考
- **ui-pocket.com/mobile** —— 移动端 UI 合集
- **pinterest.com** —— 情绪板与风格灵感

## 依赖

本插件已内置 7 个 UI 分析 Agent、design-dna skill 和子 Agent 调用引擎，**不再需要额外安装任何依赖**。

以下为可选增强：

### TinyFish 搜索（可选）

如果希望工作流能自动搜索设计参考素材，可以安装：

```bash
pi install npm:pi-tinyfish-tools
```

没有它也可以正常使用，只需在搜索阶段选择「跳过搜索」即可。

### 检查安装状态

项目提供了一个检查脚本，可以确认 prompts、agents 和依赖是否准备好：

```bash
scripts/check-install.sh
```

如果检查通过，Pi 已经打开时输入 `/reload`，然后运行 `/ui-workflow`。

## 使用方法

### npm 安装（推荐）

```bash
pi install npm:pi-ui-workflow
```

> 安装后如果 Pi 已在运行，输入 `/reload` 重新加载。

然后在**任何项目**里启动 pi，直接用 `/ui-workflow` 命令。

### 在本项目里用

```bash
cd pi-ui-workflow
pi
> /ui-workflow 我要做一个面向独立开发者的极简时间追踪工具
```

### 手动安装（备选）

```bash
mkdir -p ~/.pi/agent/agents ~/.pi/agent/prompts
cp .pi/agents/*.md ~/.pi/agent/agents/
cp .pi/prompts/*.md ~/.pi/agent/prompts/
```

注意：手动安装不会加载内置 extension，需要额外安装官方 subagent 扩展。

### 搜索方式选择

阶段 1.5 会弹窗：

| 选项 | 说明 |
|------|------|
| **TinyFish 搜索**（推荐） | 免费，已装好，搜全网 + 浏览内置网站 |
| **自定义搜索 API** | 提供 endpoint 和 key，用 curl 调用 |
| **跳过搜索** | 不搜素材，研究员基于已有描述分析 |

## 关于 HTML 原型的二次确认

阶段 4 默认**不会自动生成** HTML 原型。工作流会弹窗询问：

| 选项 | 含义 |
|------|------|
| 生成完整 HTML 原型 | 消耗较多 token，高保真可预览 |
| 仅生成 1 个关键页面（推荐） | 先看效果再决定要不要扩展 |
| 仅保留规范文档 | 不生成 HTML |
| 跳过 | 不做任何额外动作 |

## 项目结构

```
pi-ui-workflow/
├── .pi/
│   ├── agents/
│   │   ├── ui-research-analyst.md       研究员
│   │   ├── ui-need-analyst.md           需求分析师
│   │   ├── ui-form-analyst.md           形态分析师
│   │   ├── ui-visual-analyst.md         视觉分析师
│   │   ├── ui-ia-analyst.md             信息架构师（可选）
│   │   ├── ui-interaction-analyst.md    交互分析师（可选）
│   │   └── ui-content-analyst.md        内容策略师（可选）
│   └── prompts/
│       ├── ui-workflow.md               /ui-workflow 完整流程
│       ├── ui-align.md                  /ui-align 仅对齐
│       └── ui-review.md                 /ui-review 仅审核
├── docs/
│   └── usage.md                         详细使用说明
└── README.md
```

## License

MIT
