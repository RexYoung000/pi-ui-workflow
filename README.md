# pi-ui-workflow

一个为 [pi coding agent](https://github.com/earendil-works/pi-coding-agent) 设计的 **UI 设计工作流**。由一个总审核人（主控 AI）协调 7 个专业子 Agent（4 必选 + 3 可选），从需求、形态、视觉、信息架构、交互、内容六个角度全面分析，最终产出可执行的 UI 设计规范文档，可选生成高保真 HTML 原型。

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

```
阶段 1：对齐需求（主控 AI）
  ├─ 扫项目、问关键问题
  ├─ 弹窗勾选额外分析（信息架构/交互/内容，默认全勾）
  └─ 保存 docs/ui-need-summary.md
       ↓
阶段 1.5：素材搜索（主控 AI + 研究员）
  ├─ 弹窗选搜索方式（TinyFish / 自定义 API / 跳过）
  ├─ 浏览 8 个内置参考网站
  └─ 调用 ui-research-analyst → 参考素材分析报告
       ↓
阶段 2a：需求分析
  └─ 调用 ui-need-analyst → 需求分析报告
       ↓
阶段 2b：5 个专家并行（全部拿到 need + research 报告）
  ├─ ui-form-analyst        必选  形态（布局/组件）
  ├─ ui-visual-analyst      必选  视觉（配色/字体/动效 + design-dna）
  ├─ ui-ia-analyst          可选  信息架构（导航/层级）
  ├─ ui-interaction-analyst 可选  交互体验（微交互/手势）
  └─ ui-content-analyst     可选  内容策略（文案/语调）
       ↓
阶段 3：总审核（主控 AI）
  ├─ 检测冲突
  └─ 整合 docs/ui-design-spec.md
       ↓
阶段 4：HTML 原型（可选，必须二次确认）
  ├─ ask_user_question 询问
  └─ 调用 design-dna Generate → docs/prototype/*.html
```

## 7 个子 Agent

| # | Agent | 性质 | 职责 |
|---|-------|------|------|
| 1 | **ui-research-analyst** | 必选 | 分析参考素材、识别风格趋势、提炼可借鉴模式 |
| 2 | **ui-need-analyst** | 必选 | 产品定位、目标用户、核心功能、关键页面 |
| 3 | **ui-form-analyst** | 必选 | 页面类型、布局范式、组件库选型、响应式策略 |
| 4 | **ui-visual-analyst** | 必选 | 配色/字体/间距/动效 + 调用 design-dna |
| 5 | **ui-ia-analyst** | 可选 | 导航结构、信息层级、页面跳转、搜索体验 |
| 6 | **ui-interaction-analyst** | 可选 | 微交互、状态过渡、手势、可访问性 |
| 7 | **ui-content-analyst** | 可选 | 界面文案、空状态、错误提示、品牌语调 |

## 三个工作流入口

| 命令 | 用途 |
|------|------|
| `/ui-workflow <描述>` | 完整流程：对齐 → 搜索 → 分析 → 审核 → 可选原型 |
| `/ui-align` | 只跑阶段 1（对齐需求），输出需求摘要 |
| `/ui-review` | 跑阶段 1.5+2+3+4（跳过对齐，直接分析） |

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

工作流依赖两个组件：

### 1. subagent 扩展

提供 `subagent` 工具。pi 自带此扩展的例子，复制到全局即可：

```bash
mkdir -p ~/.pi/agent/extensions/subagent
# 找到你的 pi 安装目录（通常在 /usr/local/lib/node_modules/@earendil-works/pi-coding-agent）
# 复制下面的文件到 ~/.pi/agent/extensions/subagent/
#   - examples/extensions/subagent/index.ts
#   - examples/extensions/subagent/agents.ts
```

### 2. design-dna skill

视觉分析和 HTML 原型生成会用到。

```bash
mkdir -p ~/.pi/agent/skills
git clone --depth 1 https://github.com/zanwei/design-dna.git ~/.pi/agent/skills/design-dna
```

## 使用方法

### 全局安装（所有项目可用，推荐）

```bash
# 把 agents 和 prompts 复制到全局目录
mkdir -p ~/.pi/agent/agents ~/.pi/agent/prompts
cp pi-ui-workflow/.pi/agents/*.md ~/.pi/agent/agents/
cp pi-ui-workflow/.pi/prompts/*.md ~/.pi/agent/prompts/
```

然后在**任何项目**里启动 pi，直接用 `/ui-workflow` 命令。

### 在本项目里用

```bash
cd pi-ui-workflow
pi
# 然后输入：
> /ui-workflow 我要做一个面向独立开发者的极简时间追踪工具
```

### 在别的项目里用

```bash
# symlink 方式（不想装全局时使用）
ln -s /path/to/pi-ui-workflow/.pi /path/to/your-project/.pi

cd /path/to/your-project
pi
> /ui-workflow 帮我设计一个任务管理界面
```

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
