//
//  Typography.swift
//  Aisle
//
//  Created by Purnasindhu-749 on 18/07/25.
//

import UIKit

enum FontFamily {
    case inter
    case gilroy
}

enum FontWeight {
    case regular
    case medium
    case semiBold
    case bold
}

struct Typography {
    
    static func font(_ family: FontFamily, weight: FontWeight, size: CGFloat) -> UIFont {
        let fontName: String
        
        switch family {
        case .inter:
            fontName = interFontName(for: weight)
        case .gilroy:
            fontName = gilroyFontName(for: weight)
        }
        
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    private static func interFontName(for weight: FontWeight) -> String {
        switch weight {
        case .regular:
            return "Inter-Regular"
        case .medium:
            return "Inter-Medium"
        case .semiBold:
            return "Inter-SemiBold"
        case .bold:
            return "Inter-Black"
            
        }
        
    }
    
    private static func gilroyFontName(for weight: FontWeight) -> String {
        switch weight {
        case .regular:
            return "Gilroy-Regular"
        case .medium:
            return "Gilroy-Medium"
        case .semiBold:
            return "Gilroy-SemiBold"
        case .bold:
            return "Gilroy-Bold"
        }
    }
}
