//
//  URLParserService.swift
//  beautycase
//
//  URL解析服务 - 获取网页标题和封面图
//

import Foundation
import UIKit

struct ParsedURLContent {
    let title: String
    let thumbnailURL: String?
    let description: String?
}

class URLParserService {
    static let shared = URLParserService()
    
    private init() {}
    
    func parseURL(_ urlString: String) async throws -> ParsedURLContent {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15", forHTTPHeaderField: "User-Agent")
        request.timeoutInterval = 10
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        guard let html = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        let title = extractTitle(from: html) ?? url.host ?? "Untitled"
        let thumbnailURL = extractThumbnailURL(from: html, baseURL: url)
        let description = extractDescription(from: html)
        
        return ParsedURLContent(
            title: title,
            thumbnailURL: thumbnailURL,
            description: description
        )
    }
    
    func downloadThumbnail(from urlString: String?) async -> Data? {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            print("Failed to download thumbnail: \(error)")
            return nil
        }
    }
    
    private func extractTitle(from html: String) -> String? {
        // 尝试Open Graph title
        if let ogTitle = extractMetaContent(from: html, property: "og:title") {
            return ogTitle
        }
        
        // 尝试Twitter Card title
        if let twitterTitle = extractMetaContent(from: html, name: "twitter:title") {
            return twitterTitle
        }
        
        // 尝试HTML title标签
        if let titleRange = html.range(of: "<title>", options: .caseInsensitive),
           let titleEndRange = html.range(of: "</title>", options: .caseInsensitive, range: titleRange.upperBound..<html.endIndex) {
            let title = String(html[titleRange.upperBound..<titleEndRange.lowerBound])
            return title.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        return nil
    }
    
    private func extractThumbnailURL(from html: String, baseURL: URL) -> String? {
        // 尝试Open Graph image
        if let ogImage = extractMetaContent(from: html, property: "og:image") {
            return resolveURL(ogImage, baseURL: baseURL)
        }
        
        // 尝试Twitter Card image
        if let twitterImage = extractMetaContent(from: html, name: "twitter:image") {
            return resolveURL(twitterImage, baseURL: baseURL)
        }
        
        // 尝试第一个img标签
        if let imgRange = html.range(of: "<img", options: .caseInsensitive) {
            let imgSubstring = String(html[imgRange.lowerBound..<html.index(imgRange.lowerBound, offsetBy: min(500, html.distance(from: imgRange.lowerBound, to: html.endIndex)))])
            
            if let srcRange = imgSubstring.range(of: "src=\"", options: .caseInsensitive) {
                let srcStart = imgSubstring.index(srcRange.upperBound, offsetBy: 0)
                if let srcEnd = imgSubstring.range(of: "\"", range: srcStart..<imgSubstring.endIndex) {
                    let src = String(imgSubstring[srcStart..<srcEnd.lowerBound])
                    return resolveURL(src, baseURL: baseURL)
                }
            }
        }
        
        return nil
    }
    
    private func extractDescription(from html: String) -> String? {
        // 尝试Open Graph description
        if let ogDesc = extractMetaContent(from: html, property: "og:description") {
            return ogDesc
        }
        
        // 尝试meta description
        if let metaDesc = extractMetaContent(from: html, name: "description") {
            return metaDesc
        }
        
        return nil
    }
    
    private func extractMetaContent(from html: String, property: String? = nil, name: String? = nil) -> String? {
        let pattern: String
        if let property = property {
            pattern = "<meta\\s+property=[\"']\(property)[\"']\\s+content=[\"']([^\"']+)[\"']"
        } else if let name = name {
            pattern = "<meta\\s+name=[\"']\(name)[\"']\\s+content=[\"']([^\"']+)[\"']"
        } else {
            return nil
        }
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return nil
        }
        
        let range = NSRange(html.startIndex..<html.endIndex, in: html)
        if let match = regex.firstMatch(in: html, options: [], range: range),
           let contentRange = Range(match.range(at: 1), in: html) {
            return String(html[contentRange])
        }
        
        return nil
    }
    
    private func resolveURL(_ urlString: String, baseURL: URL) -> String {
        if urlString.hasPrefix("http://") || urlString.hasPrefix("https://") {
            return urlString
        }
        
        if urlString.hasPrefix("//") {
            return "https:\(urlString)"
        }
        
        if urlString.hasPrefix("/") {
            return "\(baseURL.scheme ?? "https")://\(baseURL.host ?? "")\(urlString)"
        }
        
        return "\(baseURL.absoluteString)/\(urlString)"
    }
}

