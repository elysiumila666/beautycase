import SwiftUI

struct HomePageView: View {
    @State private var selectedCategory: Category = .stars
    @State private var navigateToShowcase = false
    
    var body: some View {
        ZStack {
            // 3D背景景观
            MountainBackground()
            
            VStack(spacing: 0) {
                // 顶部状态栏
                StatusBarView()
                
                // 分类导航 - 2x2网格布局
                CategoryGridNavigation(
                    selectedCategory: $selectedCategory,
                    onCategoryTap: { category in
                        navigateToShowcase = true
                    }
                )
                
                // 3D景观互动区域
                InteractiveLandscapeView()
                
                // 底部提示卡片
                ExploreNowCard()
            }
            
            // 导航到展柜列表页面
            NavigationLink(
                destination: ShowcaseListView(category: selectedCategory),
                isActive: $navigateToShowcase,
                label: { EmptyView() }
            )
        }
        .ignoresSafeArea()
    }
}

// MountainBackground 已移动到 SharedComponents.swift

// 分类导航 - 2x2网格布局
struct CategoryGridNavigation: View {
    @Binding var selectedCategory: Category
    let onCategoryTap: (Category) -> Void
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
            ForEach(Category.allCases, id: \.self) { category in
                CategoryButton(
                    category: category,
                    isSelected: selectedCategory == category
                ) {
                    selectedCategory = category
                    onCategoryTap(category)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

// 分类按钮 - 参考图片样式
struct CategoryButton: View {
    let category: Category
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                // 图标
                Image(systemName: category.icon)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(isSelected ? .white : .primary)
                    .frame(width: 40, height: 40)
                
                // 文字
                VStack(alignment: .leading, spacing: 2) {
                    Text(category.title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(isSelected ? .white : .primary)
                    
                    Text(category.description)
                        .font(.system(size: 12))
                        .foregroundColor(isSelected ? .white.opacity(0.3) : .gray)
                }
                
                Spacer()
            }
            .padding(16)
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Color.blue : Color.clear)
                    .background(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
            )
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
