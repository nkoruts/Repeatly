//
//  TextViewWithUrl.swift
//  Repeatly
//
//  Created by Nikita Koruts on 22.10.2024.
//

import SwiftUI

struct TextPart: Identifiable, Hashable {
    let id: UUID
    let text: String
    let url: URL?
}

struct TextViewWithUrl: View {
    let text: String
    
    var body: some View {
        let parts = splitTextWithLinks(text: text)
        
        return Text(parts.reduce(AttributedString()) { partialResult, part in
            var result = partialResult
            if let url = part.url {
                var linkText = AttributedString(part.text)
                linkText.foregroundColor = ColorSystem.button.color
                linkText.link = url
                result.append(linkText)
            } else {
                result.append(AttributedString(part.text))
            }
            return result
        })
    }
    
    private func splitTextWithLinks(text: String) -> [TextPart] {
        var parts: [TextPart] = []

        let regex = try! NSRegularExpression(
            pattern: "((https?://)?[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}([a-zA-Z0-9./?=&_-]*))",
            options: []
        )
        let matches = regex.matches(
            in: text,
            options: [],
            range: NSRange(location: 0, length: text.utf16.count)
        )

        var lastIndex = text.startIndex

        for match in matches {
            if let range = Range(match.range, in: text) {
                // Добавляем текст перед ссылкой
                if lastIndex < range.lowerBound {
                    parts.append(TextPart(id: UUID(), text: String(text[lastIndex..<range.lowerBound]), url: nil))
                }
                
                // Добавляем ссылку
                let urlString = String(text[range])
                if let url = URL(string: urlString) {
                    parts.append(TextPart(id: UUID(), text: urlString, url: url))
                }
                
                lastIndex = range.upperBound
            }
        }

        // Добавляем оставшийся текст после последней ссылки
        if lastIndex < text.endIndex {
            parts.append(TextPart(id: UUID(), text: String(text[lastIndex..<text.endIndex]), url: nil))
        }

        return parts
    }
}

#Preview {
    TextViewWithUrl(text: "Здесь есть ссылка example.com и https://www.example.com и http://example.com и ещё текст.")
}
