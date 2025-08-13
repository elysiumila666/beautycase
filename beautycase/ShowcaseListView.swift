import SwiftUI

// 展柜数据模型
struct ShowcaseItem: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let rating: Double
    let reviewCount: Int
    let amenities: [String]
    let description: String
    let imageCount: Int
    let price: String
    let isFavorite: Bool
}

// 收藏品数据模型
struct CollectionItem: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let image: String
    let category: String
    let userNote: String
    let dateAdded: String
}

struct ShowcaseListView: View {
    @State private var searchText = ""
    @State private var selectedShowcase: ShowcaseItem?
    @State private var showingDetail = false
    @State private var showingAddCollection = false
    let category: Category // 添加分类参数
    
    var body: some View {
        ZStack {
            MountainBackground()
            
            VStack(spacing: 0) {
                // 顶部导航栏
                TopNavigationBar()
                
                // 搜索和筛选区域
                SearchAndFilterSection(searchText: $searchText)
                
                // 展柜内容列表
                ShowcaseContentList(
                    category: category,
                    onShowcaseTap: { showcase in
                        selectedShowcase = showcase
                        showingDetail = true
                    },
                    onAddCollection: {
                        showingAddCollection = true
                    }
                )
                
                Spacer()
            }
            
            // 收藏品详情页面覆盖层
            if showingDetail, let showcase = selectedShowcase {
                CollectionDetailOverlay(
                    showcase: showcase,
                    isPresented: $showingDetail
                )
                .transition(.move(edge: .bottom))
                .zIndex(1)
            }
            
            // 添加收藏弹窗
            if showingAddCollection {
                AddCollectionModal(
                    isPresented: $showingAddCollection,
                    category: category
                )
                .transition(.move(edge: .bottom))
                .zIndex(2)
            }
        }
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 0.3), value: showingDetail)
        .animation(.easeInOut(duration: 0.3), value: showingAddCollection)
    }
}

// 搜索和筛选区域
struct SearchAndFilterSection: View {
    @Binding var searchText: String
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("你想展示什么？", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Color.green)
                        .clipShape(Circle())
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.3), lineWidth: 1)
            )
            .cornerRadius(20)
            
            HStack(spacing: 12) {
                FilterChip(title: "我的收藏", isSelected: true)
                FilterChip(title: "2024年", isSelected: false)
                FilterChip(title: "20个物品", isSelected: false)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

// 筛选标签
struct FilterChip: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        Text(title)
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(isSelected ? .white : .primary)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(isSelected ? Color.blue : Color.clear)
                    .background(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.white.opacity(0.3), lineWidth: 1)
                    )
            )
    }
}

// 展柜内容列表
struct ShowcaseContentList: View {
    let category: Category
    let onShowcaseTap: (ShowcaseItem) -> Void
    let onAddCollection: () -> Void
    
    // 根据分类获取展柜数据
    private var showcases: [ShowcaseItem] {
        switch category {
        case .stars:
            return [
                ShowcaseItem(
                    name: "周杰伦收藏展柜",
                    location: "音乐收藏",
                    rating: 4.9,
                    reviewCount: 156,
                    amenities: ["专辑", "海报", "周边"],
                    description: "收藏了周杰伦从出道至今的所有专辑、海报和限量周边，每一件都是珍贵的回忆。",
                    imageCount: 25,
                    price: "免费",
                    isFavorite: true
                ),
                ShowcaseItem(
                    name: "Taylor Swift 珍藏",
                    location: "欧美音乐",
                    rating: 4.8,
                    reviewCount: 89,
                    amenities: ["CD", "黑胶", "签名"],
                    description: "Taylor Swift的完整专辑收藏，包括限量版黑胶唱片和亲笔签名物品。",
                    imageCount: 18,
                    price: "免费",
                    isFavorite: false
                )
            ]
        case .pets:
            return [
                ShowcaseItem(
                    name: "柯基萌宠收藏",
                    location: "宠物周边",
                    rating: 4.7,
                    reviewCount: 234,
                    amenities: ["玩偶", "照片", "用品"],
                    description: "收集了各种可爱的柯基玩偶、照片和宠物用品，每一件都充满爱意。",
                    imageCount: 32,
                    price: "免费",
                    isFavorite: true
                ),
                ShowcaseItem(
                    name: "猫咪世界",
                    location: "猫咪收藏",
                    rating: 4.6,
                    reviewCount: 167,
                    amenities: ["雕像", "画作", "玩具"],
                    description: "各种猫咪主题的收藏品，包括精美的雕像、画作和玩具。",
                    imageCount: 28,
                    price: "免费",
                    isFavorite: false
                )
            ]
        case .medal:
            return [
                ShowcaseItem(
                    name: "奥运奖牌收藏",
                    location: "体育收藏",
                    rating: 4.9,
                    reviewCount: 445,
                    amenities: ["金牌", "银牌", "铜牌"],
                    description: "收藏了历届奥运会的各种奖牌复制品，见证体育精神的传承。",
                    imageCount: 45,
                    price: "免费",
                    isFavorite: true
                ),
                ShowcaseItem(
                    name: "学校荣誉奖章",
                    location: "教育收藏",
                    rating: 4.5,
                    reviewCount: 78,
                    amenities: ["奖状", "奖杯", "证书"],
                    description: "学生时代的各种荣誉奖章和证书，记录成长路上的每一个成就。",
                    imageCount: 15,
                    price: "免费",
                    isFavorite: false
                )
            ]
        case .films:
            return [
                ShowcaseItem(
                    name: "经典电影收藏",
                    location: "影视收藏",
                    rating: 4.8,
                    reviewCount: 312,
                    amenities: ["DVD", "海报", "道具"],
                    description: "收藏了各种经典电影的DVD、海报和限量道具，是电影爱好者的天堂。",
                    imageCount: 38,
                    price: "免费",
                    isFavorite: true
                ),
                ShowcaseItem(
                    name: "动漫手办收藏",
                    location: "动漫收藏",
                    rating: 4.7,
                    reviewCount: 198,
                    amenities: ["手办", "模型", "画册"],
                    description: "各种精美的手办模型和画册，展现动漫艺术的魅力。",
                    imageCount: 42,
                    price: "免费",
                    isFavorite: false
                )
            ]
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("\(category.title)展柜")
                    .font(.system(size: 24, weight: .bold))
                
                Spacer()
                
                // 添加新收藏按钮
                Button(action: onAddCollection) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 20)
            
            // 可滑动的展柜卡片
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(showcases) { showcase in
                        ShowcaseCard(
                            showcase: showcase,
                            onTap: { onShowcaseTap(showcase) }
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.horizontal, -20)
        }
        .padding(.top, 20)
    }
}

// 展柜卡片
struct ShowcaseCard: View {
    let showcase: ShowcaseItem
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 0) {
                // 图片区域
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 280, height: 200)
                        .overlay(
                            VStack {
                                Image(systemName: "photo")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray)
                                Text("展柜图片")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        )
                    
                    // 关闭按钮
                    VStack {
                        HStack {
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "xmark")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .frame(width: 30, height: 30)
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.horizontal, 15)
                        .padding(.top, 15)
                        
                        Spacer()
                    }
                }
                
                // 信息区域
                VStack(alignment: .leading, spacing: 12) {
                    // 标题和评分
                    HStack {
                        VStack(alignment: .leading) {
                            Text(showcase.name)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.primary)
                            
                            HStack(spacing: 4) {
                                Image(systemName: "location")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text(showcase.location)
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .font(.caption)
                                    .foregroundColor(.yellow)
                                Text(String(format: "%.1f", showcase.rating))
                                    .font(.system(size: 14, weight: .bold))
                            }
                            Text("(\(showcase.reviewCount) reviews)")
                                .font(.system(size: 10))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    // 设施标签
                    HStack(spacing: 8) {
                        ForEach(showcase.amenities, id: \.self) { amenity in
                            AttributeTag(icon: getAmenityIcon(amenity), text: amenity)
                        }
                    }
                    
                    // 描述
                    Text(showcase.description)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .lineLimit(3)
                    
                    // 底部操作区域
                    HStack {
                        // 收藏按钮
                        Button(action: {}) {
                            Image(systemName: showcase.isFavorite ? "star.fill" : "star")
                                .font(.title3)
                                .foregroundColor(showcase.isFavorite ? .yellow : .gray)
                                .frame(width: 40, height: 40)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                        
                        // 分享按钮
                        Button(action: {}) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title3)
                                .foregroundColor(.blue)
                                .frame(width: 40, height: 40)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(20)
                .background(Color.olive)
                .foregroundColor(.white)
            }
            .background(.ultraThinMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.3), lineWidth: 1)
            )
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.15), radius: 15, x: 0, y: 8)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func getAmenityIcon(_ amenity: String) -> String {
        switch amenity {
        case let x where x.contains("Bed"): return "bed.double"
        case let x where x.contains("Wifi"): return "wifi"
        case let x where x.contains("Parking"): return "car"
        case let x where x.contains("View"): return "eye"
        case let x where x.contains("Garden"): return "leaf"
        case let x where x.contains("Hiking"): return "mountain.2"
        default: return "star"
        }
    }
}

// 收藏品详情覆盖层
struct CollectionDetailOverlay: View {
    let showcase: ShowcaseItem
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            // 背景
            MountainBackground()
            
            VStack(spacing: 0) {
                // 顶部导航栏
                TopNavigationBarWithClose()
                
                // 收藏品详情内容
                CollectionDetailContent(showcase: showcase)
                
                // 底部留白，确保底部tabs可见
                Spacer(minLength: 120)
            }
        }
        .ignoresSafeArea()
    }
}

// TopNavigationBarWithClose 已移动到 SharedComponents.swift

// 收藏品详情内容
struct CollectionDetailContent: View {
    let showcase: ShowcaseItem
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 主要图片
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 300)
                    .overlay(
                        VStack(spacing: 15) {
                            Image(systemName: "photo")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                            Text("收藏品大图")
                                .font(.title2)
                                .foregroundColor(.gray)
                            Text("这里显示用户上传的图片")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    )
                
                // 详情信息卡片
                DetailInfoCard(showcase: showcase)
                
                // 用户备注区域
                UserNoteSection()
                
                // 相关推荐
                RelatedRecommendationsSection()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
    }
}

// 详情信息卡片
struct DetailInfoCard: View {
    let showcase: ShowcaseItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // 标题和评分
            HStack {
                VStack(alignment: .leading) {
                    Text(showcase.name)
                        .font(.system(size: 20, weight: .bold))
                    
                    Text(showcase.location)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(String(format: "%.1f", showcase.rating))
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.orange)
                    
                    Text("(\(showcase.reviewCount) reviews)")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }
            }
            
            // 属性标签
            HStack(spacing: 15) {
                ForEach(showcase.amenities, id: \.self) { amenity in
                    AttributeTag(icon: "star", text: amenity)
                }
            }
            
            // 描述
            Text(showcase.description)
                .font(.system(size: 14))
                .foregroundColor(.primary)
                .lineLimit(nil)
            
            // 操作按钮
            Button("添加到展柜") {
                // 添加到展柜逻辑
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(25)
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.3), lineWidth: 1)
        )
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

// 用户备注区域
struct UserNoteSection: View {
    @State private var noteText = ""
    @State private var isEditingNote = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("用户备注")
                    .font(.system(size: 18, weight: .bold))
                
                Spacer()
                
                Button(isEditingNote ? "保存" : "编辑") {
                    if isEditingNote {
                        isEditingNote = false
                    } else {
                        isEditingNote = true
                    }
                }
                .foregroundColor(.blue)
            }
            
            if isEditingNote {
                TextEditor(text: $noteText)
                    .frame(height: 100)
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            } else {
                Text(noteText.isEmpty ? "点击编辑添加备注..." : noteText)
                    .foregroundColor(noteText.isEmpty ? .gray : .primary)
                    .padding(15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
            }
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.3), lineWidth: 1)
        )
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

// 相关推荐区域
struct RelatedRecommendationsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("相关推荐")
                .font(.system(size: 18, weight: .bold))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(0..<3) { index in
                        RecommendationCard(index: index)
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.horizontal, -20)
        }
    }
}

// 推荐卡片
struct RecommendationCard: View {
    let index: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 120, height: 80)
                .overlay(
                    VStack {
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                        Text("推荐\(index + 1)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                )
            
            Text("推荐收藏品\(index + 1)")
                .font(.system(size: 14, weight: .medium))
                .lineLimit(1)
            
            Text("相关类别")
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .frame(width: 120)
        .padding(12)
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.white.opacity(0.3), lineWidth: 1)
        )
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

// AttributeTag 已移动到 SharedComponents.swift

// olive 颜色已移动到 SharedComponents.swift

// 添加收藏弹窗
struct AddCollectionModal: View {
    @Binding var isPresented: Bool
    let category: Category
    @State private var collectionName = ""
    @State private var collectionDescription = ""
    @State private var selectedImages: [String] = []
    
    var body: some View {
        ZStack {
            // 半透明背景
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            // 弹窗内容
            VStack(spacing: 20) {
                // 标题
                HStack {
                    Text("添加新收藏")
                        .font(.system(size: 20, weight: .bold))
                    
                    Spacer()
                    
                    Button("×") {
                        isPresented = false
                    }
                    .font(.title2)
                    .foregroundColor(.gray)
                }
                
                // 分类信息
                HStack {
                    Image(systemName: category.icon)
                        .font(.title2)
                        .foregroundColor(.blue)
                    
                    Text("\(category.title) - \(category.description)")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                
                // 输入字段
                VStack(spacing: 15) {
                    TextField("收藏品名称", text: $collectionName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("描述", text: $collectionDescription)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // 图片上传区域
                VStack(spacing: 10) {
                    Text("上传图片（最多10张，每张不超过10MB）")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    Button("选择图片") {
                        // 图片选择逻辑
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                // 操作按钮
                HStack(spacing: 15) {
                    Button("取消") {
                        isPresented = false
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .foregroundColor(.primary)
                    .cornerRadius(10)
                    
                    Button("添加") {
                        // 添加收藏逻辑
                        isPresented = false
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding(25)
            .background(.ultraThinMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.3), lineWidth: 1)
            )
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
            .padding(.horizontal, 20)
        }
    }
}

struct ShowcaseListView_Previews: PreviewProvider {
    static var previews: some View {
        ShowcaseListView(category: .stars)
    }
}
