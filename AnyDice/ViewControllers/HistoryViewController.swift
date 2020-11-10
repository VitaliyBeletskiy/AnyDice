//
//  HistoryViewController.swift
//  AnyDice
//
//  Created by Vitaliy on 2020-10-27.
//

import UIKit

class HistoryViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    // MARK: - Properties
    
    var history: History?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        historyTableView.dataSource = self
        historyTableView.delegate = self
        //historyTableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        historyTableView.register(HistoryTableViewCell.nib(), forCellReuseIdentifier: HistoryTableViewCell.identifier)
        
        setupViewsAccordingDesign()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if history == nil { backToMainVC() }
    }

    // MARK: - Navigation
    
    private func backToMainVC() {
        guard let navController = self.navigationController else {
            Logger.error("Cannot get the ref to NavigationController.")
            return
        }
        navController.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    // add design to Views
    private func setupViewsAccordingDesign() {
        // set background color
        Design.setupBackground(view: self.view)
        // set tableView color
        Design.setupTableViewBackground(tableView: historyTableView)
        // buttons
        Design.setupButton(button: backButton)
        Design.setupButton(button: clearButton)
    }
    
    // MARK: - IBActions

    // 'Back' button tapped - transition to MainViewController
    @IBAction func backTapped(_ sender: UIButton) {
        backToMainVC()
    }
    
    // 'Clear' button tapped - delete all records in History
    @IBAction func clearTapped(_ sender: UIButton) {
        history!.rollsHistory.removeAll()
        history!.saveToUserDefaults()
        historyTableView.reloadData()
    }
    
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history!.rollsHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell
        cell?.backgroundColor = UIColor.clear
        cell?.diceConfigLabel.text = self.history?.rollsHistory[indexPath.row]["diceConfig"]
        cell?.resultLabel.text = self.history?.rollsHistory[indexPath.row]["result"]
        return cell!
    }
    
}
