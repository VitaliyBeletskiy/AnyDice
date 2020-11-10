//
//  HistoryTableViewCell.swift
//  AnyDice
//
//  Created by Vitaliy on 2020-11-02.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    // MARK: - Static
    
    static let identifier = "HistoryCell"
    
    static func nib() -> UINib {
        UINib(nibName: "HistoryTableViewCell", bundle: nil)
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var diceConfigLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        diceConfigLabel.font = Design.roundedFont(ofSize: 25, weight: .heavy)
        resultLabel.font = Design.roundedFont(ofSize: 25, weight: .heavy)
    }
    
}
