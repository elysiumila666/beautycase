# Core Data 实体创建 - 详细步骤指南

## 前提条件
1. 已经创建了 `DataModel.xcdatamodeld` 文件（如果还没创建，先完成这个）
2. 在Xcode中打开了 `DataModel.xcdatamodeld` 文件

## 如何打开 DataModel 编辑器

1. 在Xcode左侧项目导航器中，找到 `DataModel.xcdatamodeld` 文件
2. 点击这个文件
3. 中间区域会显示 Core Data 编辑器（图形界面）

---

## 第一步：创建 DailyRecord 实体

### 1.1 添加实体
- 在 Core Data 编辑器底部，你会看到一个 **"+"** 按钮（在 "ENTITIES" 标题旁边）
- 点击这个 **"+"** 按钮
- 会创建一个新实体，默认名称可能是 "Entity"

### 1.2 重命名实体
- 点击新创建的实体（在左侧的 ENTITIES 列表中）
- 在右侧面板中，找到 **Name** 字段
- 将名称改为：`DailyRecord`（注意大小写）

### 1.3 添加属性 - id
- 在右侧面板中，找到 **Attributes** 部分
- 点击 Attributes 下方的 **"+"** 按钮
- 会添加一个新属性，默认名称是 "attribute"
- 在右侧面板中：
  - **Name**: 输入 `id`
  - **Type**: 在下拉菜单中选择 `UUID`（如果没有UUID，选择 `Binary Data`）
  - **Optional**: 取消勾选（确保不是可选的）

### 1.4 添加属性 - date
- 再次点击 Attributes 下方的 **"+"** 按钮
- **Name**: 输入 `date`
- **Type**: 选择 `Date`
- **Optional**: 取消勾选

### 1.5 添加属性 - createdAt
- 再次点击 Attributes 下方的 **"+"** 按钮
- **Name**: 输入 `createdAt`
- **Type**: 选择 `Date`
- **Optional**: 取消勾选

### 1.6 添加关系 - cyberloafingItems（稍后设置）
- 在右侧面板中，找到 **Relationships** 部分
- 点击 Relationships 下方的 **"+"** 按钮
- **Name**: 输入 `cyberloafingItems`
- **Destination**: 暂时留空（等创建了 CyberloafingItem 实体后再设置）
- **Type**: 选择 `To Many`（表示一个DailyRecord可以有多个CyberloafingItem）
- **Delete Rule**: 选择 `Cascade`（删除DailyRecord时，同时删除所有关联的CyberloafingItem）

### 1.7 添加关系 - dailyCareer（稍后设置）
- 再次点击 Relationships 下方的 **"+"** 按钮
- **Name**: 输入 `dailyCareer`
- **Destination**: 暂时留空（等创建了 DailyCareer 实体后再设置）
- **Type**: 选择 `To One`（表示一个DailyRecord只有一个DailyCareer）
- **Delete Rule**: 选择 `Cascade`

---

## 第二步：创建 CyberloafingItem 实体

### 2.1 添加实体
- 点击 ENTITIES 列表下方的 **"+"** 按钮
- 将实体名称改为：`CyberloafingItem`

### 2.2 添加所有属性
按照以下顺序，每次点击 Attributes 下方的 **"+"**，然后设置：

| 属性名 | Type | Optional |
|--------|------|----------|
| `id` | UUID (或 Binary Data) | ❌ 取消勾选 |
| `url` | String | ✅ 勾选 |
| `imageData` | Binary Data | ✅ 勾选 |
| `fileType` | String | ❌ 取消勾选 |
| `title` | String | ❌ 取消勾选 |
| `thumbnailImage` | Binary Data | ✅ 勾选 |
| `fromTag` | String | ✅ 勾选 |
| `whoTag` | String | ✅ 勾选 |
| `categoryTag` | String | ✅ 勾选 |
| `createdAt` | Date | ❌ 取消勾选 |

**操作步骤**：
1. 点击 Attributes 下方的 **"+"**
2. 在右侧面板设置 Name、Type、Optional
3. 重复10次，添加所有属性

### 2.3 添加关系 - dailyRecord
- 点击 Relationships 下方的 **"+"** 按钮
- **Name**: 输入 `dailyRecord`
- **Destination**: 在下拉菜单中选择 `DailyRecord`
- **Type**: 选择 `To One`
- **Optional**: 取消勾选
- **Delete Rule**: 选择 `Nullify`
- **Inverse**: **暂时留空**（稍后在第五步统一设置）

---

## 第三步：创建 DailyCareer 实体

### 3.1 添加实体
- 点击 ENTITIES 列表下方的 **"+"** 按钮
- 将实体名称改为：`DailyCareer`

### 3.2 添加属性 - id
- 点击 Attributes 下方的 **"+"**
- **Name**: `id`
- **Type**: `UUID` (或 Binary Data)
- **Optional**: ❌ 取消勾选

### 3.3 添加属性 - threeFrogsData（重要！）
- 点击 Attributes 下方的 **"+"**
- **Name**: `threeFrogsData`
- **Type**: 在下拉菜单中，**滚动到底部**，选择 `Transformable` ⚠️
- **Optional**: ✅ 勾选
- **Transformer**: 留空（使用默认）
- **Custom Class**: 留空

### 3.4 添加其他属性
继续添加以下属性：

| 属性名 | Type | Optional |
|--------|------|----------|
| `morningActivity` | String | ✅ 勾选 |
| `afternoonActivity` | String | ✅ 勾选 |
| `eveningActivity` | String | ✅ 勾选 |
| `reflectionType` | String | ❌ 取消勾选 |
| `reflectionContent` | String | ✅ 勾选 |
| `createdAt` | Date | ❌ 取消勾选 |

### 3.5 添加关系 - dailyRecord（暂时不设置 Inverse）
- 点击 Relationships 下方的 **"+"** 按钮
- **Name**: `dailyRecord`
- **Destination**: 选择 `DailyRecord`
- **Type**: `To One`
- **Optional**: ❌ 取消勾选
- **Delete Rule**: `Nullify`
- **Inverse**: **暂时留空**（稍后在第五步统一设置）

---

## 第四步：创建 CustomTag 实体

### 4.1 添加实体
- 点击 ENTITIES 列表下方的 **"+"** 按钮
- 将实体名称改为：`CustomTag`

### 4.2 添加所有属性

| 属性名 | Type | Optional |
|--------|------|----------|
| `id` | UUID (或 Binary Data) | ❌ 取消勾选 |
| `name` | String | ❌ 取消勾选 |
| `type` | String | ❌ 取消勾选 |
| `createdAt` | Date | ❌ 取消勾选 |

---

## 第五步：完成关系设置

> 💡 **重要理解**：关系是在**各自实体**中设置的，不是都在一个实体中。每个实体需要设置自己拥有的关系。

### 5.1 设置 DailyRecord 实体的关系

#### 5.1.1 切换到 DailyRecord 实体
- 在左侧 ENTITIES 列表中，点击 `DailyRecord`

#### 5.1.2 完成 cyberloafingItems 关系
- 在 Relationships 部分，点击 `cyberloafingItems`
- **Destination**: 选择 `CyberloafingItem`（如果还没设置）
- **Inverse**: 选择 `dailyRecord`

#### 5.1.3 完成 dailyCareer 关系
- 在 Relationships 部分，点击 `dailyCareer`
- **Destination**: 选择 `DailyCareer`（如果还没设置）
- **Inverse**: 选择 `dailyRecord`

---

### 5.2 设置 CyberloafingItem 实体的关系

#### 5.2.1 切换到 CyberloafingItem 实体
- 在左侧 ENTITIES 列表中，点击 `CyberloafingItem`

#### 5.2.2 完成 dailyRecord 关系的 Inverse
- 在 Relationships 部分，点击 `dailyRecord`
- **Destination**: 应该已经设置为 `DailyRecord`（如果还没设置，选择它）
- **Inverse**: 现在应该可以看到 `cyberloafingItems` 选项了，选择它

---

### 5.3 设置 DailyCareer 实体的关系

#### 5.3.1 切换到 DailyCareer 实体
- 在左侧 ENTITIES 列表中，点击 `DailyCareer`

#### 5.3.2 完成 dailyRecord 关系的 Inverse
- 在 Relationships 部分，点击 `dailyRecord`
- **Destination**: 应该已经设置为 `DailyRecord`（如果还没设置，选择它）
- **Inverse**: 现在应该可以看到 `dailyCareer` 选项了，选择它

---

### 关系设置总结

| 实体 | 关系名称 | Destination | Inverse |
|------|----------|-------------|---------|
| **DailyRecord** | `cyberloafingItems` | CyberloafingItem | dailyRecord |
| **DailyRecord** | `dailyCareer` | DailyCareer | dailyRecord |
| **CyberloafingItem** | `dailyRecord` | DailyRecord | cyberloafingItems |
| **DailyCareer** | `dailyRecord` | DailyRecord | dailyCareer |

**关键点**：
- ✅ 每个实体的关系都在**自己的实体**中设置
- ✅ Inverse 关系是自动配对的（设置一边，另一边会自动更新）
- ✅ 设置 Inverse 时，确保 Destination 已经设置好

---

## 第六步：设置 Codegen（非常重要！）

### 6.1 选择模型文件（推荐方式）
- 在左侧项目导航器中，点击 `DataModel.xcdatamodeld` 文件（**不是单个实体，是文件本身**）
- 在中间区域，确保显示的是模型文件的概览（不是某个实体的详情）

### 6.2 在文件级别设置 Codegen（推荐）
- 在右侧面板中，切换到 **File Inspector**（第一个标签，图标是文档）
- 找到 **Codegen** 选项
- 在下拉菜单中选择 **"Category/Extension"** ⚠️
- **不要选择** "Class Definition" 或 "Manual/None"
- ✅ **这样设置后，所有实体都会使用这个模式**

### 6.3 验证每个实体的 Codegen（可选但推荐）
虽然文件级别设置会应用到所有实体，但为了确保，可以检查每个实体：

1. **检查 DailyRecord 实体**
   - 在左侧 Entities 列表中，点击 `DailyRecord`
   - 在右侧 **Data Model Inspector** 中
   - 查看 **Codegen** 选项
   - 应该显示 "Category/Extension"（继承自文件设置）

2. **检查其他实体**
   - 对 `CyberloafingItem`、`DailyCareer`、`CustomTag` 重复相同检查
   - 如果某个实体显示不同的设置，可以手动改为 "Category/Extension"

### 重要说明
- ✅ **文件级别设置**：会应用到所有实体（推荐方式）
- ✅ **实体级别设置**：可以单独覆盖（如果需要）
- ⚠️ **必须使用 "Category/Extension"**：因为我们的代码使用了扩展文件

---

## 验证清单

完成所有步骤后，检查：

- [ ] 有4个实体：DailyRecord、CyberloafingItem、DailyCareer、CustomTag
- [ ] DailyRecord 有3个属性（id, date, createdAt）和2个关系
- [ ] CyberloafingItem 有10个属性（id, url, imageData, fileType, title, thumbnailImage, fromTag, whoTag, categoryTag, createdAt）和1个关系
- [ ] DailyCareer 有8个属性（id, threeFrogsData, morningActivity, afternoonActivity, eveningActivity, reflectionType, reflectionContent, createdAt）和1个关系
- [ ] CustomTag 有4个属性（id, name, type, createdAt）
- [ ] threeFrogsData 的类型是 Transformable
- [ ] 所有关系都已设置，Inverse 都正确
- [ ] Codegen 设置为 "Category/Extension"

---

## 常见问题

### Q: 找不到 "+" 按钮？
A: 确保你点击了 ENTITIES 标题下方的区域，或者尝试右键点击 ENTITIES 列表。

### Q: 属性类型下拉菜单中没有 UUID？
A: 使用 `Binary Data` 类型也可以，代码中会正确处理。

### Q: 找不到 Transformable 类型？
A: 在类型下拉菜单中，**滚动到最底部**，Transformable 在列表的最后。

### Q: 如何删除错误的属性或关系？
A: 选中属性或关系，按 `Delete` 键删除。

### Q: Inverse 关系是灰色的，无法选择？
A: 先设置 Destination，然后 Inverse 选项才会可用。

---

## 完成后的操作

1. 保存文件：按 `Cmd+S` 保存
2. 尝试编译项目：按 `Cmd+B` 编译
3. 如果有错误，检查实体名称和属性名称是否完全匹配（区分大小写）

