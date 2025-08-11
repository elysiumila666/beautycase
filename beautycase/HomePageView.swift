import SwiftUI

struct HomePageView: View {
    @State private var selectedCategory: Category = .showcase
    
    var body: some View {
        ZStack {
            // 3D背景
            MountainBackground()
            
            VStack(spacing: 20) {
                // 顶部状态栏
                StatusBarView()
                
                // 分类导航
                CategoryNavigationView(selectedCategory: $selectedCategory)
                
                // 3D景观互动区域
                InteractiveLandscapeView()
                
                // 底部提示卡片
                ExploreNowCard()
                
                // 底部导航栏
                BottomNavigationBar()
            }
        }
        .ignoresSafeArea()
    }
}

// 3D山地森林背景
struct MountainBackground: View {
    var body: some View {
        ZStack {
            // 渐变天空
            LinearGradient(
                colors: [Color.blue.opacity(0.3), Color.blue.opacity(0.1)],
                startPoint: .top,
                endPoint: .bottom
            )
            
            // 山脉剪影
            Path { path in
                path.move(to: CGPoint(x: 0, y: 300))
                path.addLine(to: CGPoint(x: 100, y: 200))
                path.addLine(to: CGPoint(x: 200, y: 250))
                path.addLine(to: CGPoint(x: 300, y: 180))
                path.addLine(to: CGPoint(x: 400, y: 220))
                path.addLine(to: CGPoint(x: 500, y: 150))
                path.addLine(to: CGPoint(x: 600, y: 200))
                path.addLine(to: CGPoint(x: 700, y: 280))
                path.addLine(to: CGPoint(x: 800, y: 320))
            }
            .fill(Color.green.opacity(0.3))
            
            // 森林细节
            ForEach(0..<20) { _ in
                Circle()
                    .fill(Color.green.opacity(0.2))
                    .frame(width: CGFloat.random(in: 20...60))
                    .position(
                        x: CGFloat.random(in: 0...400),
                        y: CGFloat.random(in: 200...300)
                    )
            }
        }
    }
}

// 分类导航
struct CategoryNavigationView: View {
    @Binding var selectedCategory: Category
    
    var body: some View {
        HStack(spacing: 15) {
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
    }
}

// 分类按钮
struct CategoryButton: View {
    let category: Category
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: category.icon)
                    .font(.title2)
                    .foregroundColor(isSelected ? .white : .primary)
                
                Text(category.title)
                    .font(.caption)
                    .foregroundColor(isSelected ? .white : .primary)
            }
            .frame(width: 80, height: 80)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? .blue : .clear)
                    .glassmorphism()
            )
        }
    }
}

enum Category: CaseIterable {
    case showcase, collection, category, theme
    
    var title: String {
        switch self {
        case .showcase: return "展柜"
        case .collection: return "收藏"
        case .category: return "分类"
        case .theme: return "主题"
        }
    }
    
    var icon: String {
        switch self {
        case .showcase: return "house.fill"
        case .collection: return "mountain.2.fill"
        case .category: return "tag.fill"
        case .theme: return "sparkles"
        }
    }
}

// 3D景观互动区域
struct InteractiveLandscapeView: View {
    var body: some View {
        ZStack {
            // 这里将来会放置可点击的3D小屋
            ForEach(0..<3) { index in
                VStack {
                    Circle()
                        .fill(Color.orange.opacity(0.8))
                        .frame(width: 60, height: 60)
                        .overlay(
                            Text("展柜\(index + 1)")
                                .font(.caption)
                                .foregroundColor(.white)
                        )
                    
                    Text("点击查看")
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
                }
                .position(
                    x: CGFloat(150 + index * 200),
                    y: CGFloat(200 + index * 50)
                )
            }
        }
        .frame(height: 300)
    }
}

// 底部提示卡片
struct ExploreNowCard: View {
    var body: some View {
        HStack {
            Image(systemName: "hand.tap")
                .font(.title2)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("立即探索")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("点击高亮区域解锁惊艳视觉效果，发现您的虚拟收藏体验")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button("×") {
                // 关闭提示
            }
            .font(.title2)
            .foregroundColor(.gray)
        }
        .padding(20)
        .glassmorphism()
        .padding(.horizontal, 20)
    }
}

// 底部导航栏
struct BottomNavigationBar: View {
    @State private var selectedTab = 2 // 相机图标高亮
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<5) { index in
                Button(action: {
                    selectedTab = index
                }) {
                    VStack(spacing: 5) {
                        Image(systemName: tabIcons[index])
                            .font(.title2)
                            .foregroundColor(selectedTab == index ? .green : .gray)
                        
                        Text(tabTitles[index])
                            .font(.caption2)
                            .foregroundColor(selectedTab == index ? .green : .gray)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 15)
        .glassmorphism()
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
    
    private let tabIcons = ["house", "heart", "camera", "calendar", "magnifyingglass"]
    private let tabTitles = ["首页", "收藏", "拍照", "日历", "搜索"]
}

// 状态栏
struct StatusBarView: View {
    var body: some View {
        HStack {
            Text("11:30")
                .font(.caption)
                .fontWeight(.medium)
            
            Spacer()
            
            HStack(spacing: 5) {
                Image(systemName: "signal")
                Image(systemName: "battery.100")
            }
            .font(.caption)
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

// 玻璃拟物化样式
struct GlassmorphismStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

extension View {
    func glassmorphism() -> some View {
        modifier(GlassmorphismStyle())
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
