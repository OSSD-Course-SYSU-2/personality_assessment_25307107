# 🕯️ 心事述说馆

一款基于 HarmonyOS ArkTS 开发的温暖治愈类元服务。用户可以写下心事、获得 AI 生成的温暖回信、进行压力测评、以及享受每日治愈内容。

## ✨ 项目亮点

- **AI 智能回信**：写完心事即可获得 AI 实时生成的专属温暖回信，AI 不可用时自动回退到预设回信
- 8 种心事类别，每种配有引导书写提示
- **心理压力测评**：10 道专业评估题，4 个压力等级 + 定制化建议
- 每日治愈角：每日一言、每日小任务和心情签，基于日期自动推荐
- 本地关系型数据库持久化用户心事、阅读历史和任务完成状态
- 整体视觉采用暖琥珀/奶油色系，温暖治愈
- 支持 phone + tablet 的一次开发多端部署，基于 600vp 断点的自适应布局
- 支持跨设备自由流转（跨端迁移），可在手机和平板间无缝切换

## 📱 页面说明

| 页面 | 路由 | 说明 |
|------|------|------|
| Index | pages/Index | 首页，温暖欢迎页 + 三个入口卡片 |
| TestPage | pages/TestPage | 书写页，选择心事类别 → 引导书写 → AI 生成回信 |
| ResultPage | pages/ResultPage | 回信页，展示 AI 回信 + 用户写的内容回顾 |
| LoveAdvicePage | pages/LoveAdvicePage | 压力测试页，10 道题评估压力水平 + 建议 |
| FunPage | pages/FunPage | 治愈角，每日一言 + 每日小任务 + 心情签 |

## 🚀 使用流程

1. 打开应用，进入首页
2. 点击「写下心事」→ 选择心情类别 → 书写心事 → 提交 → AI 生成回信
3. 查看温暖回信，可以展开回顾自己写的内容
4. 点击「压力小测试」，10 道题快速评估压力水平，获取专业建议
5. 去治愈角获取每日一言、完成今日小任务、抽一支心情签

## 🗂️ 项目结构

```
entry/src/main/ets/
├── common/
│   ├── ResponsiveLayout.ets     # 多端适配断点系统（600vp 阈值）
│   └── FreeFlowState.ets        # 跨端迁移自由流转状态管理
├── entryability/
│   └── EntryAbility.ets         # 主 UIAbility（含跨端迁移 + 数据库初始化）
├── model/
│   └── HeartTalkModel.ets       # 数据模型定义
├── data/
│   ├── FeelingCards.ets         # 8 种心事类别 + 预设回信（AI 回退用）
│   ├── AiService.ets            # AI API 服务（DeepSeek，可配置）
│   ├── StressTestData.ets       # 压力测评题 + 结果建议
│   ├── HealingContent.ets       # 治愈内容（名言/任务/心情签）
│   └── DatabaseHelper.ets       # 本地关系型数据库辅助类
└── pages/
    ├── Index.ets                # 首页
    ├── TestPage.ets             # 书写页（含 AI 生成）
    ├── ResultPage.ets           # 回信页
    ├── LoveAdvicePage.ets       # 压力测试页
    └── FunPage.ets              # 治愈角
```

## 🤖 AI 回信配置

默认使用 DeepSeek API（便宜且效果好）。配置方法：

1. 打开 `entry/src/main/ets/data/AiService.ets`
2. 将 `AI_API_KEY` 填入你的 API Key
3. 如需更换 API 提供商，修改 `AI_API_URL` 和 `AI_MODEL`

API 兼容 OpenAI 格式，支持 DeepSeek、OpenAI、及其他兼容接口。

如果未配置 API Key 或调用失败，会自动回退到本地预设回信。

## 🛠️ 开发环境

- **框架**: HarmonyOS ArkTS
- **SDK版本**: 6.0.2(22)
- **目标设备**: Phone / Tablet
- **运行系统**: HarmonyOS

## 📋 运行说明

1. 使用 DevEco Studio 打开项目
2. 在 Tools > Device Manager 中创建并启动手机模拟器或平板模拟器
3. 点击运行按钮，选择目标模拟器
4. 应用启动后自动进入首页

### 多端适配说明

- Phone 端保持单列滚动布局，适合快速浏览和单手操作
- Tablet 端使用更宽的内容容器（最大 960vp，占屏幕 72%），可通过 ResponsiveLayout 调整
- 统一通过 600vp 断点控制卡片宽度、按钮尺寸和页面留白

### 自由流转说明

- 在任意页面操作时，状态自动同步到 FreeFlowState 管理器
- 触发跨端迁移时（如手机→平板），EntryAbility 将状态写入 Want 参数
- 目标设备自动恢复到对应页面和状态（书写进度、回信内容、压力测试进度等）
- 首页提供流转调试面板，可手动模拟跨端迁移测试

## 🎨 设计体系

采用 **暖纸质触感风格（Soft-Surface Paper）**，参考 InnerHue 心理安全配色体系与 Serene 情绪可视化设计：

| Token | 色值 | 用途 |
|-------|------|------|
| 页面背景 | `#F9F6F2` | 暖纸色基础背景 |
| 卡片底色 | `#FFFFFF` | 洁白纸卡 |
| 暖色底纹 | `#FDF8F4` | 收件标签、回顾区 |
| 主色 Terracotta | `#C8896E` | 主按钮、标题强调、签筒渐变 |
| 主色浅底 | `#F5EBE4` | 图标容器 |
| 渐变 Top | `#D4A373` | 头部渐变暖金端 |
| 文字主色 | `#3D3028` | 正文（暖深棕） |
| 文字次要 | `#8B7D72` | 副标题 |
| 文字弱化 | `#BFB4A8` | 说明、提示、占位 |
| 边框 | `#EDE6DE` | 卡片边界 |
| 阴影 | `#D8CFC4` | 卡片投影 |
| Sage 绿 | `#9BAF8A` | 任务完成标识 |

核心设计原则：
- **纸质触感** — 所有卡片模拟纸卡质感，白底 + 暖灰细边框 + 弱阴影
- **大头圆角** — 卡片 18-22px、按钮 21-27px，消除冰冷直角
- **长信笺排版** — 回信页用折痕装饰、手写体落款、宽行距正文
- **情绪胶囊** — 心情选择用列表式胶囊替代网格 emoji，更安静不吵闹
- **温柔微交互** — 设计上避免强刺激，留白充足，行距 24-34px

## 🗄️ 本地数据库

应用使用 HarmonyOS 关系型数据库（`@kit.ArkData`），包含三张表：

| 表名 | 用途 |
|------|------|
| confessions | 用户心事记录（类别、内容、AI回信） |
| reading_history | 故事阅读历史 |
| task_completions | 每日任务完成状态 |

数据库在 EntryAbility.onCreate 中初始化，所有页面通过 DatabaseHelper 单例访问。
