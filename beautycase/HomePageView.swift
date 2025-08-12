import SwiftUI

struct HomePageView: View {
    @State private var selectedCategory: Category = .hotel
    
    var body: some View {
        ZStack {
            // 3D背景景观
            MountainBackground()
            
            VStack(spacing: 0) {
                // 顶部状态栏
                StatusBarView()
                
                // 分类导航 - 2x2网格布局
                CategoryGridNavigation(selectedCategory: $selectedCategory)
                
                // 3D景观互动区域
                InteractiveLandscapeView()
                
                // 底部提示卡片
                ExploreNowCard()
            }
        }
        .ignoresSafeArea()
    }
}

// MountainBackground 已移动到 SharedComponents.swift

// 分类导航 - 2x2网格布局
struct CategoryGridNavigation: View {
    @Binding var selectedCategory: Category
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 20) {
            ForEach(Category.allCases, id: \.self) { category in
                CategoryButton(
                    category: category,
                    isSelected: selectedCategory == category
                ) {
                    selectedCategory = category
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

// 分类按钮
struct CategoryButton: View {
    let category: Category
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: category.icon)
                    .font(.system(size: 28))
                    .foregroundColor(isSelected ? .white : .primary)
                
                Text(category.title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(isSelected ? .white : .primary)
            }
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? Color.blue : Color.clear)
                    .background(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            )
        }
    }
}

enum Category: CaseIterable {
    case hotel, excursions, restaurants, spa
    
    var title: String {
        switch self {
        case .hotel: return "展柜"
        case .excursions: return "收藏"
        case .restaurants: return "分类"
        case .spa: return "主题"
        }
    }
    
    var icon: String {
        switch self {
        case .hotel: return "house.fill"
        case .excursions: return "mountain.2.fill"
        case .restaurants: return "tag.fill"
        case .spa: return "sparkles"
        }
    }
}

// 3D景观互动区域
struct InteractiveLandscapeView: View {
    var body: some View {
        ZStack {
            // 可点击的3D小屋
            ForEach(0..<3) { index in
                VStack(spacing: 8) {
                    // 小屋图标
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.brown.opacity(0.8))
                        .frame(width: 40, height: 30)
                        .overlay(
                            Image(systemName: "house.fill")
                                .foregroundColor(.white)
                                .font(.caption)
                        )
                    
                    // 价格标签
                    Text("\(120 + index * 10)$")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.orange)
                        .cornerRadius(8)
                }
                .position(
                    x: CGFloat(150 + index * 200),
                    y: CGFloat(250 + index * 60)
                )
            }
        }
        .frame(height: 350)
    }
}

// 底部提示卡片
struct ExploreNowCard: View {
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "hand.tap")
                .font(.title2)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("立即探索")
                    .font(.system(size: 16, weight: .bold))
                
                Text("点击高亮区域解锁惊艳视觉效果，发现您的虚拟收藏体验")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Button("×") {
                // 关闭提示
            }
            .font(.title2)
            .foregroundColor(.gray)
            .frame(width: 30, height: 30)
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.3), lineWidth: 1)
        )
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 20)
    }
}

// StatusBarView 已移动到 SharedComponents.swift

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
