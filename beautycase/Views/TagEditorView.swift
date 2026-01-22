//
//  TagEditorView.swift
//  beautycase
//
//  标签编辑器 - 编辑From、Who、Category标签
//

import SwiftUI
import CoreData

struct TagEditorView: View {
    let item: CyberloafingItem
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var fromTags: [CustomTag] = []
    @State private var whoTags: [CustomTag] = []
    @State private var categoryTags: [CustomTag] = []
    
    @State private var selectedFromTag: String? = nil
    @State private var selectedWhoTag: String? = nil
    @State private var selectedCategoryTag: String? = nil
    
    @State private var showingFromTagInput = false
    @State private var showingWhoTagInput = false
    @State private var showingCategoryTagInput = false
    
    @State private var newFromTag = ""
    @State private var newWhoTag = ""
    @State private var newCategoryTag = ""
    
    var body: some View {
        NavigationView {
            List {
                // From Tag Section
                Section {
                    ForEach(fromTags, id: \.id) { tag in
                        Button(action: {
                            selectedFromTag = tag.name
                            item.fromTag = tag.name
                            PersistenceController.shared.save()
                        }) {
                            HStack {
                                Image(systemName: "tag.fill")
                                    .foregroundColor(.blue)
                                Text(tag.name)
                                Spacer()
                                if selectedFromTag == tag.name {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                    
                    Button(action: {
                        showingFromTagInput = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add new")
                        }
                        .foregroundColor(.blue)
                    }
                } header: {
                    Text("🏷️ From")
                }
                
                // Who Tag Section
                Section {
                    ForEach(whoTags, id: \.id) { tag in
                        Button(action: {
                            selectedWhoTag = tag.name
                            item.whoTag = tag.name
                            PersistenceController.shared.save()
                        }) {
                            HStack {
                                Image(systemName: "at")
                                    .foregroundColor(.green)
                                Text(tag.name)
                                Spacer()
                                if selectedWhoTag == tag.name {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.green)
                                }
                            }
                        }
                    }
                    
                    Button(action: {
                        showingWhoTagInput = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add new")
                        }
                        .foregroundColor(.green)
                    }
                } header: {
                    Text("@ Who")
                }
                
                // Category Tag Section
                Section {
                    ForEach(categoryTags, id: \.id) { tag in
                        Button(action: {
                            selectedCategoryTag = tag.name
                            item.categoryTag = tag.name
                            PersistenceController.shared.save()
                        }) {
                            HStack {
                                Image(systemName: "folder.fill")
                                    .foregroundColor(.orange)
                                Text(tag.name)
                                Spacer()
                                if selectedCategoryTag == tag.name {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.orange)
                                }
                            }
                        }
                    }
                    
                    Button(action: {
                        showingCategoryTagInput = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add new")
                        }
                        .foregroundColor(.orange)
                    }
                } header: {
                    Text("📁 Category")
                }
            }
            .navigationTitle("Edit Tags")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                loadTags()
                loadItemTags()
            }
            .alert("Add From Tag", isPresented: $showingFromTagInput) {
                TextField("Tag name", text: $newFromTag)
                Button("Cancel", role: .cancel) {}
                Button("Add") {
                    addTag(name: newFromTag, type: "from")
                    newFromTag = ""
                }
            }
            .alert("Add Who Tag", isPresented: $showingWhoTagInput) {
                TextField("Tag name", text: $newWhoTag)
                Button("Cancel", role: .cancel) {}
                Button("Add") {
                    addTag(name: newWhoTag, type: "who")
                    newWhoTag = ""
                }
            }
            .alert("Add Category Tag", isPresented: $showingCategoryTagInput) {
                TextField("Tag name", text: $newCategoryTag)
                Button("Cancel", role: .cancel) {}
                Button("Add") {
                    addTag(name: newCategoryTag, type: "category")
                    newCategoryTag = ""
                }
            }
        }
    }
    
    private func loadTags() {
        let persistenceController = PersistenceController.shared
        fromTags = persistenceController.getCustomTags(type: "from")
        whoTags = persistenceController.getCustomTags(type: "who")
        categoryTags = persistenceController.getCustomTags(type: "category")
    }
    
    private func loadItemTags() {
        selectedFromTag = item.fromTag
        selectedWhoTag = item.whoTag
        selectedCategoryTag = item.categoryTag
    }
    
    private func addTag(name: String, type: String) {
        guard !name.isEmpty else { return }
        let persistenceController = PersistenceController.shared
        _ = persistenceController.createCustomTag(name: name, type: type)
        loadTags()
    }
}

struct TagEditorView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let item = CyberloafingItem(context: context)
        return TagEditorView(item: item)
    }
}

