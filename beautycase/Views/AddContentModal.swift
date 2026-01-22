//
//  AddContentModal.swift
//  beautycase
//
//  添加内容弹窗 - 支持链接、图片、PDF、Word等类型
//

import SwiftUI
import PhotosUI

struct AddContentModal: View {
    let selectedDate: Date
    let onDismiss: () -> Void
    
    @State private var selectedContentType: ContentType? = nil
    @State private var urlString = ""
    @State private var isParsing = false
    @State private var selectedImage: UIImage? = nil
    @State private var selectedPhotosItem: PhotosPickerItem? = nil
    @Environment(\.dismiss) private var dismiss
    
    enum ContentType {
        case url
        case image
        case pdf
        case word
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    if selectedContentType == nil {
                        // 选择内容类型
                        VStack(spacing: 20) {
                            ContentTypeButton(
                                icon: "link",
                                title: "Link",
                                subtitle: "Add URL"
                            ) {
                                selectedContentType = .url
                            }
                            
                            ContentTypeButton(
                                icon: "photo",
                                title: "Image",
                                subtitle: "Add photo"
                            ) {
                                selectedContentType = .image
                            }
                            
                            ContentTypeButton(
                                icon: "doc.fill",
                                title: "PDF",
                                subtitle: "Add PDF file"
                            ) {
                                selectedContentType = .pdf
                            }
                            
                            ContentTypeButton(
                                icon: "doc.text.fill",
                                title: "Word",
                                subtitle: "Add Word document"
                            ) {
                                selectedContentType = .word
                            }
                        }
                        .padding(.top, 40)
                    } else {
                        // 内容输入界面
                        contentInputView
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
            }
            .navigationTitle("Add Content")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                if selectedContentType != nil {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Back") {
                            selectedContentType = nil
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var contentInputView: some View {
        switch selectedContentType {
        case .url:
            urlInputView
        case .image:
            imageInputView
        case .pdf, .word:
            fileInputView
        case .none:
            EmptyView()
        }
    }
    
    private var urlInputView: some View {
        VStack(spacing: 20) {
            TextField("Paste URL here", text: $urlString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.URL)
            
            if isParsing {
                ProgressView("Parsing URL...")
            } else {
                Button("Add") {
                    addURL()
                }
                .buttonStyle(.borderedProminent)
                .disabled(urlString.isEmpty)
            }
        }
    }
    
    private var imageInputView: some View {
        VStack(spacing: 20) {
            PhotosPicker(selection: $selectedPhotosItem, matching: .images) {
                VStack(spacing: 12) {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 300)
                            .cornerRadius(12)
                    } else {
                        Image(systemName: "photo.badge.plus")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)
                        Text("Select Image")
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            
            if selectedImage != nil {
                Button("Add") {
                    addImage()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .onChange(of: selectedPhotosItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    selectedImage = image
                }
            }
        }
    }
    
    private var fileInputView: some View {
        VStack(spacing: 20) {
            Text("File picker coming soon")
                .foregroundColor(.gray)
        }
    }
    
    private func addURL() {
        guard !urlString.isEmpty else { return }
        isParsing = true
        
        Task {
            do {
                let parser = URLParserService.shared
                let parsed = try await parser.parseURL(urlString)
                
                let thumbnailData = await parser.downloadThumbnail(from: parsed.thumbnailURL)
                
                await MainActor.run {
                    let persistenceController = PersistenceController.shared
                    let dailyRecord = persistenceController.getOrCreateDailyRecord(for: selectedDate)
                    let context = persistenceController.container.viewContext
                    
                    let item = CyberloafingItem(context: context)
                    item.id = UUID()
                    item.url = urlString
                    item.title = parsed.title
                    item.fileType = "url"
                    item.thumbnailImage = thumbnailData
                    item.createdAt = Date()
                    item.dailyRecord = dailyRecord
                    
                    persistenceController.save()
                    isParsing = false
                    dismiss()
                    onDismiss()
                }
            } catch {
                await MainActor.run {
                    isParsing = false
                    // 处理错误
                }
            }
        }
    }
    
    private func addImage() {
        guard let image = selectedImage,
              let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        let persistenceController = PersistenceController.shared
        let dailyRecord = persistenceController.getOrCreateDailyRecord(for: selectedDate)
        let context = persistenceController.container.viewContext
        
        let item = CyberloafingItem(context: context)
        item.id = UUID()
        item.imageData = imageData
        item.title = "Image"
        item.fileType = "image"
        item.thumbnailImage = imageData
        item.createdAt = Date()
        item.dailyRecord = dailyRecord
        
        persistenceController.save()
        dismiss()
        onDismiss()
    }
}

struct ContentTypeButton: View {
    let icon: String
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(.black)
                    .frame(width: 40)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                    
                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.gray.opacity(0.05))
            .cornerRadius(12)
        }
    }
}

struct AddContentModal_Previews: PreviewProvider {
    static var previews: some View {
        AddContentModal(selectedDate: Date()) {}
    }
}

