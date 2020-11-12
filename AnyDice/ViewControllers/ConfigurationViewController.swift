//
//  ConfigurationViewController.swift
//  AnyDice
//
//  Created by Vitaliy on 2020-10-27.
//

import UIKit

class ConfigurationViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var diceSetTableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var helpDeleteLabel: UILabel!
    @IBOutlet weak var helpDiceLabel: UILabel!
    
    
    // MARK: - Properties
    
    weak var delegate: ConfigurationDelegate?
    var diceSetArray: [DiceSet] = []
        
    // MARK: - Private Properties

    private var chosenDiceArrayIndex: Int?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupViewsAccordingDesign()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleHelpViewTap(_:)))
        helpView.addGestureRecognizer(tap)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? ChooseDiceViewController {
            target.chosenDiceArrayIndex = self.chosenDiceArrayIndex
            target.delegate = self
        }
    }
    
    // performs transition to MainViewController
    private func goBackToMainVC() {
        guard let navController = self.navigationController else {
            Logger.error("Cannot get the ref to NavigationController")
            return
        }
        navController.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        diceSetTableView.delegate = self
        diceSetTableView.dataSource = self
        diceSetTableView.allowsSelection = false // upon selection a row changes its color
        diceSetTableView.rowHeight = UITableView.automaticDimension
        diceSetTableView.estimatedRowHeight = 100.0
        //diceSetTableView.register(DiceSetTableViewCell.self, forCellReuseIdentifier: DiceSetTableViewCell.identifier)
        diceSetTableView.register(DiceSetTableViewCell.nib(), forCellReuseIdentifier: DiceSetTableViewCell.identifier)
    }
    
    private func setupViewsAccordingDesign() {
        // set background color
        Design.setupBackground(view: view)
        // set TableView background color
        Design.setupTableViewBackground(tableView: diceSetTableView)
        // buttons
        Design.setupButton(button: cancelButton)
        Design.setupButton(button: saveButton)
        Design.setupButton(button: addButton)
        Design.setupButton(button: helpButton)
        // labels
        Design.setupLabelBlack(label: helpDeleteLabel)
        Design.setupLabelBlack(label: helpDiceLabel)
    }
    
    @objc private func handleHelpViewTap(_ sender: UITapGestureRecognizer? = nil) {
        helpView.alpha = 0
    }
    
    
    // MARK: - IBActions
    
    // 'Cancel' button tapped - go back to MainViewController
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        goBackToMainVC()
    }
    
    // 'Save' button tapped - save a new Dice configuration
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        delegate?.updateDices(diceSetArray: diceSetArray)
        goBackToMainVC()
    }
    
    // 'Add' button tapped - add a new row
    @IBAction func plusTapped(_ sender: UIButton) {
        diceSetArray.append(DiceSet(faces: 6, quantity: 1))
        diceSetTableView.reloadData()
    }
    
    // '?' button tapped - show helpView
    @IBAction func helpButtonTapped(_ sender: UIButton) {
        helpView.alpha = 1
    }
    
}

/// Add 'TableView' conformance.
extension ConfigurationViewController: UITableViewDelegate, UITableViewDataSource {
    
    // returns number of rows for TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diceSetArray.count
    }
    
    // returns and sets up a partucular row for TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiceSetTableViewCell.identifier, for: indexPath) as? DiceSetTableViewCell
        cell?.delegate = self
        cell?.setupRow(diceArrayIndex: indexPath.row, diceFaces: diceSetArray[indexPath.row].faces, quantity: diceSetArray[indexPath.row].quantity)
        return cell!
    }
    
    // allows editing (deleting and adding rows)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if diceSetArray.count == 1 {
            return false
        }
        return true
    }
    
    // deletes a row from TableView (by swiping to the left)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            self.diceSetArray.remove(at: indexPath.row)
            self.diceSetTableView.deleteRows(at: [indexPath], with: .fade)
            self.diceSetTableView.reloadData()
        }
        deleteAction.backgroundColor = Design.buttonColor
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
}

/// Add 'TableCellDelegate' conformance.
extension ConfigurationViewController: DiceTableDelegate {
    
    // called when we hit the dice image in the row
    func didChooseCell(diceArrayIndex: Int) {
        chosenDiceArrayIndex = diceArrayIndex
        performSegue(withIdentifier: Constants.segueToChooseDiceVC, sender: self)
    }
    
    // called when we change dices quantity in the row
    func updateDicesQuantity(diceArrayIndex: Int, newDicesQuantity: Int) {
        diceSetArray[diceArrayIndex].quantity = newDicesQuantity
    }

}

/// Add 'ChooseDiceDelegate' conformance.
extension ConfigurationViewController: ChooseDiceDelegate {
    
    func updateDiceFaces(diceArrayIndex: Int, diceFaces: Int) {
        chosenDiceArrayIndex = diceArrayIndex
        diceSetArray[diceArrayIndex].faces = diceFaces
        diceSetTableView.reloadData()
    }

}
