# StellarCase iOS App - 数字收藏展柜

## 🚀 项目概述

**StellarCase** 是一款创新的iOS应用，为用户提供3D数字化展柜功能，让用户能够分类展示和收藏珍视的物品。

### 核心概念
- **3D数字化展柜** - 分类展示用户珍视的物品
- **平面图片→3D化展示** - 支持多张图片的3D重建
- **实体物品数字化收藏** - 将珍贵物品数字化保存
- **情感化社交产品** - 展示自我认同，同好交流

## 🎯 产品定位

### 目标用户
- 收藏爱好者
- 文艺青年
- 追星族
- 怀旧人群
- 潮玩爱好者

### 差异化优势
| 痛点 | 解决方案 |
|------|----------|
| 珍贵照片淹没在相册 | 独立展柜分类突出重要记忆 |
| 实体收藏品不便携带 | 3D数字化随身展柜 |
| 情感物品需要仪式感 | 定制化展示空间 |

## 🏗️ 技术架构

### 开发环境
- **平台**: iOS 14.0+
- **语言**: Swift 5.0+
- **框架**: SwiftUI
- **设计模式**: MVVM

### 核心技术栈
- **UI框架**: SwiftUI + Combine
- **3D渲染**: SceneKit (计划中)
- **图片处理**: Core Image (计划中)
- **数据存储**: Core Data (计划中)

## 📱 界面设计

### 设计风格
- **玻璃拟物化 (Glassmorphism)**: 使用 `.background(.ultraThinMaterial)`
- **3D背景景观**: 山地森林背景，增强沉浸感
- **半透明效果**: 毛玻璃质感，背景景观若隐若现

### 三屏布局设计
1. **主页 (HomePageView)**
   - 2x2网格分类导航
   - 3D景观互动区域
   - 可点击的展柜预览

2. **展柜内容 (ShowcaseListView)**
   - 搜索和筛选功能
   - 展柜列表展示
   - 图片画廊预览

3. **单个收藏详情 (CollectionDetailView)**
   - 大图展示区域
   - 收藏品信息展示
   - **备注编辑功能** ⭐

## 🔧 项目结构

```
beautycase/
├── beautycaseApp.swift          # 主应用入口
├── MainNavigationView.swift     # 主导航系统
├── SharedComponents.swift       # 🆕 共享UI组件
├── HomePageView.swift           # 首页（自己的展柜）
├── ExplorePageView.swift        # 🆕 探索页（社区）
├── ProfilePageView.swift        # 🆕 我的（个人主页）
├── ShowcaseListView.swift       # 展柜内容页面
├── CollectionDetailView.swift   # 单个收藏详情页
├── Assets.xcassets/             # 资源文件
└── Preview Content/             # 预览内容
```

### 核心组件说明
- **beautycaseApp.swift**: 应用入口点，配置主视图
- **MainNavigationView.swift**: 主导航系统，管理三个主要页面的切换
- **SharedComponents.swift**: 🆕 共享UI组件库，避免重复定义
  - `MountainBackground`: 3D山地森林背景
  - `TopNavigationBar`: 顶部导航栏
  - `AttributeTag`: 属性标签组件
  - `StatusBarView`: 状态栏组件
  - `BottomTabBar`: 🆕 玻璃拟物化底部导航栏
- **HomePageView.swift**: 首页界面，包含分类导航和3D景观互动
- **ExplorePageView.swift**: 🆕 探索页面，展示社区内容和热门展柜
- **ProfilePageView.swift**: 🆕 个人主页，用户信息和设置
- **ShowcaseListView.swift**: 展柜内容页面，展示展柜列表和搜索功能
- **CollectionDetailView.swift**: 单个收藏详情页，支持备注编辑功能

## 📊 开发进度

### ✅ 已完成功能
- [x] 项目基础架构搭建
- [x] 三屏UI界面实现
- [x] 毛玻璃效果实现
- [x] 3D背景景观
- [x] 分类导航系统
- [x] 搜索筛选界面
- [x] 备注编辑功能
- [x] 🆕 共享组件模块化
- [x] 🆕 代码重复问题修复

### 🚧 进行中功能
- [ ] 图片上传功能
- [ ] 展柜创建逻辑

### 📋 待开发功能
- [ ] 3D模型重建算法
- [ ] 图片压缩和优化
- [ ] 本地数据存储
- [ ] 用户认证系统

## 🎨 UI组件库

### 通用样式
```swift
// 毛玻璃效果
.background(.ultraThinMaterial)

// 圆角边框
.overlay(
    RoundedRectangle(cornerRadius: 20)
        .stroke(.white.opacity(0.3), lineWidth: 1)
)
```

## 🔄 开发流程

### 开发原则
1. **配置驱动开发** - 使用集中式配置文件管理项目状态
2. **敏捷开发流程** - 优先讨论核心功能，快速上线MVP版本
3. **设计先行** - 重视UI审美，确保视觉体验品质
4. **深度讨论** - 编码前充分确认产品细节

### 迭代计划
1. **MVP版本** (当前) - 基础UI框架
2. **功能版本** (下一阶段) - 图片上传、展柜管理
3. **高级版本** (未来) - 3D重建、社交功能

## 🚨 已知问题

### 技术限制
- 3D重建算法性能待优化
- 大量图片的内存管理
- 毛玻璃效果在低端设备上的性能

## 📈 性能指标

### 目标性能
- **启动时间**: < 2秒
- **页面切换**: < 300ms
- **图片加载**: < 1秒

### 兼容性
- **iOS版本**: 14.0+
- **设备支持**: iPhone 6s及以上

---

**最后更新**: 2024年12月
**版本**: 1.0.0-alpha
**状态**: 开发中
