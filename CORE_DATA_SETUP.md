# Core Data 模型设置说明

## ⚠️ 重要提示

**如果你不熟悉在Xcode图形界面中创建实体和属性，请先查看详细步骤指南：**

👉 **[CORE_DATA_STEP_BY_STEP.md](CORE_DATA_STEP_BY_STEP.md)** - 包含每一步的详细操作说明

---

## 需要在Xcode中手动创建Core Data模型文件

由于Core Data模型文件（.xcdatamodeld）是二进制格式，需要在Xcode中手动创建。

### 步骤：

1. 在Xcode中，右键点击 `beautycase` 文件夹
2. 选择 "New File..."
3. 选择 "Data Model"（在Core Data分类下）
4. 命名为 `DataModel.xcdatamodeld`
5. 点击 "Create"

### 在DataModel中创建以下实体：

> 💡 **提示**：如果你不知道如何在图形界面中操作，请查看 [CORE_DATA_STEP_BY_STEP.md](CORE_DATA_STEP_BY_STEP.md) 获取详细步骤

#### 1. DailyRecord
- **Attributes:**
  - `id`: UUID (Optional: No)
  - `date`: Date (Optional: No)
  - `createdAt`: Date (Optional: No)
- **Relationships:**
  - `cyberloafingItems`: To Many → CyberloafingItem (Delete Rule: Cascade)
  - `dailyCareer`: To One → DailyCareer (Delete Rule: Cascade)

#### 2. CyberloafingItem
- **Attributes:**
  - `id`: UUID (Optional: No)
  - `url`: String (Optional: Yes)
  - `imageData`: Binary Data (Optional: Yes)
  - `fileType`: String (Optional: No)
  - `title`: String (Optional: No)
  - `thumbnailImage`: Binary Data (Optional: Yes)
  - `fromTag`: String (Optional: Yes)
  - `whoTag`: String (Optional: Yes)
  - `categoryTag`: String (Optional: Yes)
  - `createdAt`: Date (Optional: No)
- **Relationships:**
  - `dailyRecord`: To One → DailyRecord (Optional: No, Delete Rule: Nullify)

#### 3. DailyCareer
- **Attributes:**
  - `id`: UUID (Optional: No)
  - `threeFrogsData`: Binary Data (Optional: Yes) - Transformable类型，存储JSON
  - `morningActivity`: String (Optional: Yes)
  - `afternoonActivity`: String (Optional: Yes)
  - `eveningActivity`: String (Optional: Yes)
  - `reflectionType`: String (Optional: No)
  - `reflectionContent`: String (Optional: Yes)
  - `createdAt`: Date (Optional: No)
- **Relationships:**
  - `dailyRecord`: To One → DailyRecord (Optional: No, Delete Rule: Nullify)

#### 4. CustomTag
- **Attributes:**
  - `id`: UUID (Optional: No)
  - `name`: String (Optional: No)
  - `type`: String (Optional: No) - 值："from", "who", 或 "category"
  - `createdAt`: Date (Optional: No)

### 详细设置步骤：

#### 设置 `threeFrogsData` 为 Transformable 类型

1. 在Xcode中打开 `DataModel.xcdatamodeld`
2. 选择 `DailyCareer` 实体
3. 选择 `threeFrogsData` 属性
4. 在右侧的 **Data Model Inspector**（右侧面板）中：
   - **Type**: 选择 "Transformable"
   - **Transformer**: 留空（使用默认的NSSecureUnarchiveFromDataTransformer）
   - **Custom Class**: 留空（会自动使用NSData）

#### 设置 Codegen 模式

**重要：必须设置为 "Category/Extension" 模式！**

1. 在Xcode中，选择 `DataModel.xcdatamodeld` 文件（不是单个实体）
2. 在右侧的 **File Inspector** 中：
   - 找到 **Codegen** 选项
   - 选择 **"Category/Extension"**（不是 "Class Definition"）
   - 这样Xcode会生成基础的NSManagedObject类，我们创建的扩展文件会添加额外功能

3. **对每个实体单独设置**（可选但推荐）：
   - 选择实体（如 `DailyRecord`）
   - 在右侧 **Data Model Inspector** 中
   - **Codegen**: 选择 "Category/Extension"

### 为什么使用 Category/Extension 模式？

- 我们已经在代码中创建了扩展文件（如 `DailyRecord.swift`）
- Category/Extension 模式让Xcode生成基础类，我们的扩展添加自定义属性和方法
- 如果使用 "Class Definition"，Xcode会覆盖我们的代码

### 注意事项：

- ✅ `threeFrogsData` **必须**设置为 **Transformable** 类型
- ✅ **Codegen** **必须**设置为 **"Category/Extension"**
- ✅ 创建实体时，属性名称必须与上面列出的完全一致（区分大小写）
- ✅ UUID类型在Core Data中实际存储为UUID，但Xcode中可能显示为"UUID"或"Binary Data"

