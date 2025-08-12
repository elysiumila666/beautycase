import SwiftUI

struct CollectionDetailView: View {
    @State private var noteText = ""
    @State private var isEditingNote = false
    
    var body: some View {
        ZStack {
            MountainBackground()
            
            VStack(spacing: 0) {
                // 顶部导航栏
                TopNavigationBar()
                
                // 大图展示区域
                ImageDisplayArea()
                
                // 底部详情卡片
                DetailCard(
                    noteText: $noteText,
                    isEditingNote: $isEditingNote
                )
            }
        }
        .ignoresSafeArea()
    }
}

// TopNavigationBar 已移动到 SharedComponents.swift

// 大图展示区域
struct ImageDisplayArea: View {
    var body: some View {
        ZStack {
            // 主图片
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 400)
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
            
            // 左上角关闭按钮
            VStack {
                HStack {
                    Button("×") {
                        // 关闭详情页
                    }
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.black.opacity(0.5))
                    .clipShape(Circle())
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Spacer()
            }
            
            // 右下角操作按钮
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack(spacing: 15) {
                        Button(action: {}) {
                            Image(systemName: "star.fill")
                                .font(.title2)
                                .foregroundColor(.yellow)
                                .frame(width: 50, height: 50)
                                .background(Color.white.opacity(0.9))
                                .clipShape(Circle())
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title2)
                                .foregroundColor(.blue)
                                .frame(width: 50, height: 50)
                                .background(Color.white.opacity(0.9))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
            }
        }
    }
}

// 底部详情卡片
struct DetailCard: View {
    @Binding var noteText: String
    @Binding var isEditingNote: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // 标题和评分
            HStack {
                VStack(alignment: .leading) {
                    Text("珍贵收藏品")
                        .font(.system(size: 20, weight: .bold))
                    
                    Text("个人收藏 • 2024年获得")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("4.9")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.orange)
                    
                    Text("(23条评价)")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }
            }
            
            // 属性标签
            HStack(spacing: 15) {
                AttributeTag(icon: "calendar", text: "2024年")
                AttributeTag(icon: "tag", text: "收藏品")
                AttributeTag(icon: "heart", text: "珍贵")
            }
            
            // 备注编辑区域
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("备注")
                        .font(.system(size: 16, weight: .bold))
                    
                    Spacer()
                    
                    Button(isEditingNote ? "保存" : "编辑") {
                        if isEditingNote {
                            // 保存备注
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
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
            }
            
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
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}

// AttributeTag 已移动到 SharedComponents.swift

struct CollectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionDetailView()
    }
}
