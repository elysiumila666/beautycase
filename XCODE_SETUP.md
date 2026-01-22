# Xcode项目设置指南

## 问题1：Xcode中看不到新创建的文件

### 原因
新创建的 `Models`、`Services`、`Views` 文件夹中的文件还没有添加到Xcode项目中。

### 解决方法（两种方式任选其一）

#### 方法1：在Xcode中手动添加文件（推荐）

1. **打开Xcode项目**
   - 双击 `beautycase.xcodeproj` 打开项目

2. **添加Models文件夹中的文件**
   - 在Xcode左侧项目导航器中，右键点击 `beautycase` 文件夹
   - 选择 "Add Files to 'beautycase'..."
   - 导航到 `beautycase/Models/` 文件夹
   - 选择以下文件（按住Command键可多选）：
     - `DailyRecord.swift`
     - `CyberloafingItem.swift`
     - `DailyCareer.swift`
     - `CustomTag.swift`
   - ✅ 确保勾选 "Copy items if needed"（如果文件不在项目目录内）
   - ✅ 确保勾选 "Create groups"（不是folder references）
   - ✅ **重要**：在 "Add to targets" 中，**只勾选 `beautycase`**（主应用target）
   - ❌ **不要勾选** `beautycaseTests` 或 `beautycaseUITests`（这些是测试target）
   - 点击 "Add"

3. **添加Services文件夹中的文件**
   - 重复步骤2，但这次选择 `beautycase/Services/` 文件夹中的：
     - `PersistenceController.swift`
     - `URLParserService.swift`
     - `FileParserService.swift`

4. **添加Views文件夹中的文件**
   - 重复步骤2，但这次选择 `beautycase/Views/` 文件夹中的所有文件：
     - `MainView.swift`
     - `DatePickerView.swift`
     - `CyberloafingView.swift`
     - `AddContentModal.swift`
     - `TagEditorView.swift`
     - `DailyCareerView.swift`
     - `TimeBlocksSlider.swift`
     - `ReflectionTabView.swift`

#### 方法2：使用Xcode的"Add Files"功能自动添加整个文件夹

1. 在Xcode中，选择 `beautycase` 文件夹
2. 右键 → "Add Files to 'beautycase'..."
3. 选择 `beautycase/Models` 文件夹
4. ✅ 勾选 "Create groups"
5. ✅ **重要**：在 "Add to targets" 中，**只勾选 `beautycase`**
   - ❌ 不要勾选 `beautycaseTests`
   - ❌ 不要勾选 `beautycaseUITests`
6. 点击 "Add"
7. 对 `Services` 和 `Views` 文件夹重复相同操作（都只勾选 `beautycase` target）

### 验证文件已添加
添加后，你应该能在Xcode左侧导航器中看到：
```
beautycase/
├── Models/
│   ├── DailyRecord.swift
│   ├── CyberloafingItem.swift
│   ├── DailyCareer.swift
│   └── CustomTag.swift
├── Services/
│   ├── PersistenceController.swift
│   ├── URLParserService.swift
│   └── FileParserService.swift
└── Views/
    ├── MainView.swift
    ├── DatePickerView.swift
    ├── CyberloafingView.swift
    ├── AddContentModal.swift
    ├── TagEditorView.swift
    ├── DailyCareerView.swift
    ├── TimeBlocksSlider.swift
    └── ReflectionTabView.swift
```

## 问题2：编译错误

添加文件后，如果出现编译错误，请确保：
1. 所有文件都已添加到Target（在File Inspector中检查）
2. 项目设置中Swift版本正确（建议Swift 5.0+）
3. 先完成Core Data模型设置（见CORE_DATA_SETUP.md）

