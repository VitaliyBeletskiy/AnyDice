//
//  Design.swift
//  AnyDice
//
//  Created by Vitaliy on 2020-11-07.
//

import UIKit

class Design {
    
    // Design constants
    static let screenBackgroundColor = "#ADADADFF"
    //static let screenBackgroundColor = "#8D8D8DFF"
    //static let screenBackgroundColor = "#6EA355FF"
    static let mainScreenCirclesColor = "#F79B16FF"
    static let buttonColor = "#8B4E81FF"
    // font size
    static let fontSizeTotalLabelNormal: CGFloat = 150
    static let fontSizeRollButton: CGFloat = 40
    static let fontSizeAllButtonLabel: CGFloat = 25
    
    
    static func setupBackground(view: UIView) {
        view.backgroundColor = UIColor(hex: self.screenBackgroundColor)
    }
    
    static func setupTableViewBackground(tableView: UITableView) {
        tableView.backgroundColor = UIColor(hex: self.screenBackgroundColor)
    }
    
    static func setupButton(button: UIButton, fontSize: CGFloat = Design.fontSizeAllButtonLabel) {
        button.backgroundColor = UIColor(hex: self.buttonColor)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = self.roundedFont(ofSize: fontSize, weight: .heavy)
        button.setTitleColor(.white, for: .normal)
    }
    
    static func setupButtonNoCorners(button: UIButton, fontSize: CGFloat = Design.fontSizeAllButtonLabel) {
        button.backgroundColor = UIColor(hex: self.buttonColor)
        button.titleLabel?.font = self.roundedFont(ofSize: fontSize, weight: .heavy)
        button.setTitleColor(.white, for: .normal)
    }
    
    static func setupCircle(circleView: UIView, cornerRadius: CGFloat) {
        circleView.backgroundColor = UIColor(hex: self.mainScreenCirclesColor)
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
