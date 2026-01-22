//
//  FileParserService.swift
//  beautycase
//
//  文件解析服务 - 支持图片、PDF、Word等文件类型
//

import Foundation
import UIKit
import UniformTypeIdentifiers

enum FileType: String {
    case url = "url"
    case image = "image"
    case pdf = "pdf"
    case word = "word"
    case unknown = "unknown"
}

struct ParsedFileContent {
    let title: String
    let thumbnailData: Data?
    let fileType: FileType
    let fileData: Data?
}

class FileParserService {
    static let shared = FileParserService()
    
    private init() {}
    
    func parseFile(from url: URL) async throws -> ParsedFileContent {
        let fileExtension = url.pathExtension.lowercased()
        let fileType = determineFileType(from: fileExtension)
        
        guard let fileData = try? Data(contentsOf: url) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        let title = extractFileName(from: url)
        let thumbnailData = try await generateThumbnail(for: fileData, fileType: fileType)
        
        return ParsedFileContent(
            title: title,
            thumbnailData: thumbnailData,
            fileType: fileType,
            fileData: fileData
        )
    }
    
    func parseImage(from data: Data) -> ParsedFileContent {
        let title = "Image"
        return ParsedFileContent(
            title: title,
            thumbnailData: data,
            fileType: .image,
            fileData: data
        )
    }
    
    private func determineFileType(from extension: String) -> FileType {
        switch `extension` {
        case "jpg", "jpeg", "png", "gif", "heic", "webp":
            return .image
        case "pdf":
            return .pdf
        case "doc", "docx":
            return .word
        default:
            return .unknown
        }
    }
    
    private func extractFileName(from url: URL) -> String {
        let fileName = url.deletingPathExtension().lastPathComponent
        return fileName.isEmpty ? "Untitled" : fileName
    }
    
    private func generateThumbnail(for data: Data, fileType: FileType) async throws -> Data? {
        switch fileType {
        case .image:
            // 对于图片，直接返回压缩后的数据
            return compressImage(data)
        case .pdf:
            // PDF缩略图生成（简化版，实际需要PDFKit）
            return nil
        case .word:
            // Word文档缩略图（需要特殊处理）
            return nil
        default:
            return nil
        }
    }
    
    private func compressImage(_ data: Data) -> Data? {
        guard let image = UIImage(data: data) else {
            return data
        }
        
        // 压缩图片到合适大小（最大宽度800px）
        let maxDimension: CGFloat = 800
        let size = image.size
        
        var newSize = size
        if size.width > maxDimension || size.height > maxDimension {
            let ratio = min(maxDimension / size.width, maxDimension / size.height)
            newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage?.jpegData(compressionQuality: 0.8)
    }
}

