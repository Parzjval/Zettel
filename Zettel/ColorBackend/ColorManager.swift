//
//  ColorManager.swift
//  Zettel
//
//  Created by Михаил Трапезников on 12.11.2021.
//

import Foundation
import UIKit

protocol ColorManagerProtocol {
    func getColor() -> UIColor
}

final class ColorManager: ColorManagerProtocol {
    
    static let shared: ColorManagerProtocol = ColorManager()
    
    static var colors: [Color] = []
    static let specialColor: Color = Color(color: UIColor(red: 218/256, green: 218/256, blue: 218/256, alpha: 0.0))
    
    private init() {
        setColors()
    }
    
    func setColors() {
        let div: CGFloat = 256
        ColorManager.colors = [
            Color(color: UIColor(red: 228/div, green: 234/div, blue: 252/div, alpha: 0.4)),
            Color(color: UIColor(red: 192/div, green: 163/div, blue: 210/div, alpha: 0.4)),
            Color(color: UIColor(red: 243/div, green: 195/div, blue: 209/div, alpha: 0.4)),
            Color(color: UIColor(red: 189/div, green: 218/div, blue: 245/div, alpha: 0.4)),
            Color(color: UIColor(red: 245/div, green: 227/div, blue: 179/div, alpha: 0.4)),
            Color(color: UIColor(red: 187/div, green: 186/div, blue: 244/div, alpha: 0.4)),
            Color(color: UIColor(red: 242/div, green: 182/div, blue: 218/div, alpha: 0.4)),
            Color(color: UIColor(red: 182/div, green: 242/div, blue: 191/div, alpha: 0.4)),
            Color(color: UIColor(red: 182/div, green: 217/div, blue: 242/div, alpha: 0.4)),
            Color(color: UIColor(red: 223/div, green: 182/div, blue: 242/div, alpha: 0.4)),
            Color(color: UIColor(red: 226/div, green: 157/div, blue: 157/div, alpha: 0.4)),
            Color(color: UIColor(red: 180/div, green: 226/div, blue: 157/div, alpha: 0.4)),
            Color(color: UIColor(red: 188/div, green: 157/div, blue: 226/div, alpha: 0.4)),
            Color(color: UIColor(red: 157/div, green: 226/div, blue: 226/div, alpha: 0.4)),
        ]
    }
    
    func getColor() -> UIColor {
        return ColorManager.colors.randomElement()!.color
    }
    
    
}
