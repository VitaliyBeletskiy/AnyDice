//
//  DiceTableViewCell.swift
//  AnyDice
//
//  Created by Vitaliy on 2020-10-27.
//

import UIKit

class DiceTableViewCell: UITableViewCell {

    // MARK: - Static
    
    static let identifier = "DiceCell"
    
    static func nib() -> UINib {
        UINib(nibName: "DiceTableViewCell", bundle: nil)
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var diceImage: UIImageView!
    @IBOutlet weak var diceLabel: UILabel!
    
    // MARK: - Properties
    
    var diceFaces: Int?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        diceLabel.font = Design.roundedFont(ofSize: 25, weight: .heavy)
    }
    
    // MARK: - Public Methods
    
    func setupCellViews(diceFaces: Int) {
        self.diceFaces = diceFaces
        self.diceLabel.text = "\(diceFaces) faces"
        self.diceImage.image = Utilities.resizeImage(image: UIImage(systemName: "\(diceFaces).square")!, targetSize: CGSize(width: 80.0, height: 80.0))
    }
    
}
