# Core Data 详细设置指南

## 第一步：创建 DataModel.xcdatamodeld 文件

1. 在Xcode中，右键点击 `beautycase` 文件夹（左侧项目导航器）
2. 选择 **"New File..."**（或按 `Cmd+N`）
3. 在模板选择器中：
   - 选择 **iOS** → **Core Data** → **Data Model**
   - 点击 **Next**
4. 文件名输入：`DataModel`
5. ✅ 确保 "Add to targets: beautycase" 已勾选
6. 点击 **Create**

## 第二步：设置 Codegen 模式（重要！）

在创建模型文件后，**立即**设置Codegen模式：

1. 在项目导航器中，点击 `DataModel.xcdatamodeld` 文件
2. 在右侧的 **File Inspector**（第一个标签页）中
3. 找到 **Codegen** 下拉菜单
4. 选择 **"Category/Extension"** ⚠️ **不要选择 "Class Definition"**
5. 这样Xcode会生成基础类，我们的扩展文件会添加功能

## 第三步：创建实体和属性

### 创建 DailyRecord 实体

1. 在Xcode底部，点击 **"+"** 按钮添加实体
2. 在右侧面板中，将实体名称改为 `DailyRecord`
3. 添加属性（点击 Attributes 下方的 "+"）：
   
   | 属性名 | 类型 | Optional |
   |--------|------|----------|
   | `id` | UUID | ❌ No |
   | `date` | Date | ❌ No |
   | `createdAt` | Date | ❌ No |

4. 添加关系（点击 Relationships 下方的 "+"）：
   - `cyberloafingItems`
     - Type: To Many
     - Destination: CyberloafingItem（稍后创建）
     - Delete Rule: Cascade
   - `dailyCareer`
     - Type: To One
     - Destination: DailyCareer（稍后创建）
     - Delete Rule: Cascade

### 创建 CyberloafingItem 实体

1. 添加新实体，命名为 `CyberloafingItem`
2. 添加属性：

   | 属性名 | 类型 | Optional |
   |--------|------|----------|
   | `id` | UUID | ❌ No |
   | `url` | String | ✅ Yes |
   | `imageData` | Binary Data | ✅ Yes |
   | `fileType` | String | ❌ No |
   | `title` | String | ❌ No |
   | `thumbnailImage` | Binary Data | ✅ Yes |
   | `fromTag` | String | ✅ Yes |
   | `whoTag` | String | ✅ Yes |
   | `categoryTag` | String | ✅ Yes |
   | `createdAt` | Date | ❌ No |

3. 添加关系：
   - `dailyRecord`
     - Type: To One
     - Destination: DailyRecord
     - Optional: ❌ No
     - Delete Rule: Nullify
     - Inverse: cyberloafingItems

### 创建 DailyCareer 实体

1. 添加新实体，命名为 `DailyCareer`
2. 添加属性：

   | 属性名 | 类型 | Optional | 特殊设置 |
   |--------|------|----------|----------|
   | `id` | UUID | ❌ No | - |
   | `threeFrogsData` | Transformable | ✅ Yes | ⚠️ 见下方说明 |
   | `morningActivity` | String | ✅ Yes | - |
   | `afternoonActivity` | String | ✅ Yes | - |
   | `eveningActivity` | String | ✅ Yes | - |
   | `reflectionType` | String | ❌ No | - |
   | `reflectionContent` | String | ✅ Yes | - |
   | `createdAt` | Date | ❌ No | - |

3. **设置 `threeFrogsData` 为 Transformable**：
   - 选择 `threeFrogsData` 属性
   - 在右侧 **Data Model Inspector** 中：
     - **Type**: 选择 "Transformable"
     - **Transformer**: 留空（使用默认）
     - **Custom Class**: 留空

4. 添加关系：
   - `dailyRecord`
     - Type: To One
     - Destination: DailyRecord
     - Optional: ❌ No
     - Delete Rule: Nullify
     - Inverse: dailyCareer

### 创建 CustomTag 实体

1. 添加新实体，命名为 `CustomTag`
2. 添加属性：

   | 属性名 | 类型 | Optional |
   |--------|------|----------|
   | `id` | UUID | ❌ No |
   | `name` | String | ❌ No |
   | `type` | String | ❌ No |
   | `createdAt` | Date | ❌ No |

## 第四步：验证设置

完成所有实体创建后，检查：

1. ✅ 所有实体名称正确（区分大小写）
2. ✅ 所有属性名称正确（区分大小写）
3. ✅ `threeFrogsData` 类型为 Transformable
4. ✅ Codegen 设置为 "Category/Extension"
5. ✅ 所有关系都已设置，Inverse关系正确

## 常见问题

### Q: UUID类型在Xcode中找不到？
A: 在较新版本的Xcode中，UUID可能显示为"UUID"类型。如果没有，使用"Binary Data"类型也可以。

### Q: Transformable类型在哪里？
A: 在属性类型下拉菜单的最底部，选择"Transformable"。

### Q: 如何设置Inverse关系？
A: 创建关系后，在右侧面板的"Inverse"下拉菜单中选择对应的关系。例如，`CyberloafingItem.dailyRecord` 的Inverse应该是 `DailyRecord.cyberloafingItems`。

### Q: 编译时提示找不到实体？
A: 确保：
1. DataModel.xcdatamodeld文件已添加到Target
2. 实体名称拼写正确（区分大小写）
3. 保存了.xcdatamodeld文件（Cmd+S）

