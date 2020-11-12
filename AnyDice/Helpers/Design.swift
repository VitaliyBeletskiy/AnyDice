//
//  Design.swift
//  AnyDice
//
//  Created by Vitaliy on 2020-11-07.
//

import UIKit

struct Design {
    
    // to prevent accidental instantiating
    private init() {}
    
    // colors
    static let screenBackgroundColor = UIColor(hex: "#ADADADFF")
    //static let screenBackgroundColor = UIColor(hex: "#8D8D8DFF")
    //static let screenBackgroundColor = UIColor(hex: "#6EA355FF")
    static let mainScreenCirclesColor = UIColor(hex: "#F79B16FF")
    static let buttonColor = UIColor(hex: "#8B4E81FF")
    // font sizes
    static let fontSizeTotalLabelNormal: CGFloat = 150
    static let fontSizeRollButton: CGFloat = 40
    static let fontSizeAllButtonLabel: CGFloat = 25
    
    
    static func setupBackground(view: UIView) {
        view.backgroundColor = self.screenBackgroundColor
    }
    
    static func setupTableViewBackground(tableView: UITableView) {
        tableView.backgroundColor = self.screenBackgroundColor
    }
    
    static func setupButton(button: UIButton, fontSize: CGFloat = Design.fontSizeAllButtonLabel) {
        button.backgroundColor = self.buttonColor
        button.layer.cornerRadius = 20
        button.titleLabel?.font = self.roundedFont(ofSize: fontSize, weight: .heavy)
        button.setTitleColor(.white, for: .normal)
    }
    
    static func setupButtonNoCorners(button: UIButton, fontSize: CGFloat = Design.fontSizeAllButtonLabel) {
        button.backgroundColor = self.buttonColor
        button.titleLabel?.font = self.roundedFont(ofSize: fontSize, weight: .heavy)
        button.setTitleColor(.white, for: .normal)
    }
    
    static func setupCircle(circleView: UIView, cornerRadius: CGFloat) {
        circleView.backgroundColor = self.mainScreenCirclesColor
        circleView.layer.cornerRadius = cornerRadius
    }
    
    static func setupLabelWhite(label: UILabel, fontSize: CGFloat = Design.fontSizeAllButtonLabel) {
        label.font = Design.roundedFont(ofSize: fontSize, weight: .heavy)
        label.textColor = .white
    }
    
    static func setupLabelBlack(label: UILabel, fontSize: CGFloat = 25) {
        label.font = Design.roundedFont(ofSize: fontSize, weight: .heavy)
        label.textColor = .black
    }
    
    static func roundedFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
        let font: UIFont
        
        if #available(iOS 13.0, *) {
            if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
                font = UIFont(descriptor: descriptor, size: fontSize)
            } else {
                font = systemFont
            }
        } else {
            font = systemFont
        }
        
        return font
    }
}
