//
//  NSAttributedString.swift
//  MovieDataBaseApp
//
//  Created by Ashutosh Bisht on 28/07/24.
//

import Foundation
extension NSAttributedString {
    static func createStyledAttributedString(
        fullText: String,
        targetTexts: [String],
        targetAttributes: [NSAttributedString.Key: Any],
        defaultAttributes: [NSAttributedString.Key: Any]
    ) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: fullText, attributes: defaultAttributes)
        
        // Apply styles for each target text
        for targetText in targetTexts {
            let targetRange = (fullText as NSString).range(of: targetText)
            attributedString.addAttributes(targetAttributes, range: targetRange)
        }
        
        return attributedString
    }
}
