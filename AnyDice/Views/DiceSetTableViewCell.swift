//
//  DiceSetTableViewCell.swift
//  AnyDice
//
//  Created by Vitaliy on 2020-10-27.
//

import UIKit

class DiceSetTableViewCell: UITableViewCell {
    
    // MARK: - Static
    
    static let identifier = "DiceSetCell"
    
    static func nib() -> UINib {
        UINib(nibName: "DiceSetTableViewCell", bundle: nil)
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var diceButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var stepperView: UIView!
    
    // MARK: - Public Properties
    
    weak var delegate: DiceTableDelegate?
    
    // MARK: - Private Properties
    
    private var diceArrayIndex: Int?
    private var quantity: Int = 1
    private var diceFaces: Int = 6
    private var didSetupConstraints: Bool = false
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViewsAccordingDesign()
    }

    override func updateConstraints() {
        super.updateConstraints()
        
        if didSetupConstraints { return }  // in order not to run it twice
        
        // diceButton
        diceButton.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonHeightConstraint = diceButton.heightAnchor.constraint(equalToConstant: 80)
        buttonHeightConstraint.priority = UILayoutPriority(rawValue: 750)
        
        let buttonTopConstraint = diceButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        buttonTopConstraint.priority = UILayoutPriority(rawValue: 750)
        
        let buttonBottomConstraint = diceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        buttonBottomConstraint.priority = UILayoutPriority(rawValue: 750)
        
        NSLayoutConstraint.activate([
            diceButton.widthAnchor.constraint(equalToConstant: 80),
            buttonHeightConstraint,
            diceButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            buttonTopConstraint,
            buttonBottomConstraint
        ])
        // quantityLabel
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quantityLabel.trailingAnchor.constraint(equalTo: diceButton.leadingAnchor, constant: 0),
            quantityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        // stepperView
        stepperView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stepperView.widthAnchor.constraint(equalToConstant: 122),
            stepperView.heightAnchor.constraint(equalToConstant: 40),
            stepperView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            stepperView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        // minusButton
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minusButton.widthAnchor.constraint(equalToConstant: 60),
            minusButton.heightAnchor.constraint(equalToConstant: 40),
            minusButton.leadingAnchor.constraint(equalTo: stepperView.leadingAnchor, constant: 0),
            minusButton.centerYAnchor.constraint(equalTo: stepperView.centerYAnchor)
        ])
        // plusButton
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusButton.widthAnchor.constraint(equalToConstant: 60),
            plusButton.heightAnchor.constraint(equalToConstant: 40),
            plusButton.trailingAnchor.constraint(equalTo: stepperView.trailingAnchor, constant: 0),
            plusButton.centerYAnchor.constraint(equalTo: stepperView.centerYAnchor)
        ])
        
        didSetupConstraints = true
    }
    
    // MARK: - Private Methods
    
    private func setupViewsAccordingDesign() {
        backgroundColor = .clear
        quantityLabel.font = Design.roundedFont(ofSize: 25, weight: .heavy)
        stepperView.layer.cornerRadius = 10
        stepperView.layer.masksToBounds = true
        Design.setupButtonNoCorners(button: minusButton)
        Design.setupButtonNoCorners(button: plusButton)
    }
    
    // MARK: - Public Methods

    func setupRow(diceArrayIndex: Int, diceFaces: Int, quantity: Int) {

        self.diceArrayIndex = diceArrayIndex
        self.diceFaces = diceFaces
        self.quantity = quantity
        
        let image = Utilities.resizeImage(image: UIImage(systemName: "\(diceFaces).square")!, targetSize: CGSize(width: 80.0, height: 80.0))
        diceButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFill
        diceButton.setImage(image, for: UIControl.State.normal)
        
        quantityLabel.text = "\(quantity) d "
    }
    
    // MARK: - IBActions
    
    @IBAction func diceButtonTapped(_ sender: Any) {
        delegate?.didChooseCell(diceArrayIndex: self.diceArrayIndex!)
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        if quantity > 1 {
            quantity -= 1
            quantityLabel.text = "\(quantity) d "
            delegate?.updateDicesQuantity(diceArrayIndex: diceArrayIndex!, newDicesQuantity: quantity)
        }
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        if quantity < 99 {
            quantity += 1
            quantityLabel.text = "\(quantity) d "
            delegate?.updateDicesQuantity(diceArrayIndex: diceArrayIndex!, newDicesQuantity: quantity)
        }
    }

}
