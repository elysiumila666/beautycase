import SwiftUI

// MARK: - 共享UI组件

// 3D山地森林背景
struct MountainBackground: View {
    var body: some View {
        ZStack {
            // 渐变天空
            LinearGradient(
                colors: [Color.blue.opacity(0.4), Color.blue.opacity(0.1)],
                startPoint: .top,
                endPoint: .bottom
            )
            
            // 山脉剪影
            Path { path in
                path.move(to: CGPoint(x: 0, y: 350))
                path.addLine(to: CGPoint(x: 100, y: 250))
                path.addLine(to: CGPoint(x: 200, y: 300))
                path.addLine(to: CGPoint(x: 300, y: 230))
                path.addLine(to: CGPoint(x: 400, y: 270))
                path.addLine(to: CGPoint(x: 500, y: 200))
                path.addLine(to: CGPoint(x: 600, y: 250))
                path.addLine(to: CGPoint(x: 700, y: 330))
                path.addLine(to: CGPoint(x: 800, y: 370))
            }
            .fill(Color.green.opacity(0.4))
            
            // 森林细节
            ForEach(0..<25) { _ in
                Circle()
                    .fill(Color.green.opacity(0.3))
                    .frame(width: CGFloat.random(in: 25...70))
                    .position(
                        x: CGFloat.random(in: 0...400),
                        y: CGFloat.random(in: 250...350)
                    )
            }
        }
    }
}

// 顶部导航栏
struct TopNavigationBar: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            HStack(spacing: 15) {
                Button(action: {}) {
                    Image(systemName: "bell")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                
                Button(action: {}) {
                    Image(systemName: "gearshape")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: 35, height: 35)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.blue)
                    )
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

// 属性标签
struct AttributeTag: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 10))
            Text(text)
                .font(.system(size: 10))
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
    }
}

// 状态栏
struct StatusBarView: View {
    var body: some View {
        HStack {
            Text("11:30")
                .font(.system(size: 14, weight: .medium))
            
            Spacer()
            
            HStack(spacing: 5) {
                Image(systemName: "signal")
                Image(systemName: "wifi")
                Image(systemName: "battery.100")
            }
            .font(.caption)
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

// 底部导航栏 - 玻璃拟物化风格
struct BottomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<3) { index in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedTab = index
                    }
                }) {
                    VStack(spacing: 0) {
                        // 图标
                        Image(systemName: tabIcons[index])
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(selectedTab == index ? .white : .primary)
                            .frame(width: 50, height: 50)
                            .background(
                                Circle()
                                    .fill(selectedTab == index ? Color.green : Color.clear)
                                    .scaleEffect(selectedTab == index ? 1.0 : 0.8)
                            )
                            .scaleEffect(selectedTab == index ? 1.1 : 1.0)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 30)
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(.white.opacity(0.3), lineWidth: 1)
        )
        .cornerRadius(30)
        .shadow(color: .black.opacity(0.15), radius: 15, x: 0, y: 8)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
    
    private let tabIcons = ["house.fill", "location.north.fill", "person.fill"]
}

struct SharedComponents_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StatusBarView()
            TopNavigationBar()
            AttributeTag(icon: "star", text: "示例")
        }
        .background(Color.gray.opacity(0.1))
    }
}
