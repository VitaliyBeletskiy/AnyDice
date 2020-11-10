//
//  ChooseDiceViewController.swift
//  AnyDice
//
//  Created by Vitaliy on 2020-10-27.
//

import UIKit

class ChooseDiceViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var diceTableView: UITableView!
    @IBOutlet weak var viewWithTableView: UIView!
    @IBOutlet weak var chooseDiceLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: - Public Properties
    
    var chosenDiceArrayIndex: Int?
    weak var delegate: ChooseDiceDelegate?
    
    // MARK: - Private Properties
    
    private let diceFaces: [Int] = Array(2...50)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupViewsAccordingDesign()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        diceTableView.delegate = self
        diceTableView.dataSource = self
        diceTableView.rowHeight = UITableView.automaticDimension
        diceTableView.estimatedRowHeight = 70.0
        //diceTableView.register(DiceTableViewCell.self, forCellReuseIdentifier: DiceTableViewCell.identifier)
        diceTableView.register(DiceTableViewCell.nib(), forCellReuseIdentifier: DiceTableViewCell.identifier)
    }
    
    private func setupViewsAccordingDesign() {
        viewWithTableView.layer.cornerRadius = 20
        viewWithTableView.layer.masksToBounds = true
        
        Design.setupBackground(view: viewWithTableView)
        Design.setupTableViewBackground(tableView: diceTableView)
        Design.setupButtonNoCorners(button: cancelButton)
        Design.setupLabelWhite(label: chooseDiceLabel)
    }
    
    // MARK: - IBActions

    @IBAction func cancelTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

/// Add 'TableView' conformance.
extension ChooseDiceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diceFaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiceTableViewCell.identifier, for: indexPath) as? DiceTableViewCell
        cell?.setupCellViews(diceFaces: diceFaces[indexPath.row])
        cell?.backgroundColor = .clear
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.updateDiceFaces(diceArrayIndex: self.chosenDiceArrayIndex!, diceFaces: diceFaces[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
}
