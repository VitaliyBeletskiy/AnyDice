//
//  MainViewController.swift
//  AnyDice
//
//  Created by Vitaliy on 2020-10-27.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var minTextLabel: UILabel!
    @IBOutlet weak var maxTextLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var dicesButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var rollButton: UIButton!
    @IBOutlet weak var totalCircleView: UIView!
    @IBOutlet weak var minCircleView: UIView!
    @IBOutlet weak var maxCircleView: UIView!
    
    // MARK: - Properties
    
    var diceStack: DiceStack = DiceStack()
    var history: History = History()
    
    // MARK: - Private Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        // read Dices configuration from UserDefaults
        self.diceStack.restoreFromUserDefaults()
        if self.diceStack.dices.count == 0 {
            self.diceStack.dices.append(DiceSet(faces: 6, quantity: 1))
        }
        // read History from UserDefaults
        self.history.restoreFromUserDefaults()
        
        setupViewsAccordingDesign()
        updateViewsForDiceConfiguration()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate else {
            Logger.error("Cannot get reference for SceneDelegate.")
            return
        }
        if sceneDelegate.history == nil {
            sceneDelegate.history = self.history
        }
    }
    
    // MARK: - Navigation
    
    // prepare data for segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? ConfigurationViewController {
            target.delegate = self
            // надо копировать, чтобы продублировать инстансы DiceSet
            target.diceSetArray = self.diceStack.dices.map { $0.copy() as! DiceSet }
        }
        if let target = segue.destination as? HistoryViewController {
            target.history = self.history
        }
    }
    
    // MARK: - Private Methods
    
    private func updateViewsForDiceConfiguration() {
        self.totalLabel.text = "?"
        self.minLabel.text = String(diceStack.minValue)
        self.maxLabel.text = String(diceStack.maxValue)
        // TODO: change totalLabel font size if maxValue > 1000
    }
    
    // apply design to Views
    private func setupViewsAccordingDesign() {
        // set background color
        Design.setupBackground(view: self.view)
        // setup Circles
        Design.setupCircle(circleView: totalCircleView, cornerRadius: 150)
        Design.setupCircle(circleView: minCircleView, cornerRadius: 45)
        Design.setupCircle(circleView: maxCircleView, cornerRadius: 45)
        // setup Labels
        Design.setupLabelWhite(label: minTextLabel)
        Design.setupLabelWhite(label: minLabel)
        Design.setupLabelWhite(label: maxTextLabel)
        Design.setupLabelWhite(label: maxLabel)
        Design.setupLabelWhite(label: totalLabel, fontSize: Design.fontSizeTotalLabelNormal)
        totalLabel.adjustsFontSizeToFitWidth = true
        totalLabel.minimumScaleFactor = 0.1
        // buttons
        Design.setupButton(button: rollButton, fontSize: Design.fontSizeRollButton)
        Design.setupButton(button: dicesButton)
        Design.setupButton(button: historyButton)
    }
    
    // MARK: - IBActions

    // 'Dice' button tapped - transition to ConfigurationViewController
    @IBAction func buttonDicesTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constants.segueToConfigurationVC, sender: self)
    }
    
    // 'History' button tapped - transition to HistoryViewController
    @IBAction func buttonHistoryTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constants.segueToHistoryVC, sender: self)
    }
    
    // 'ROLL' button tapped - roll dices, return the result
    @IBAction func rollTapped(_ sender: UIButton) {
        if self.diceStack.isEmpty {
            // TODO: inform user that diceStack is empty
            return
        }
        Spinner.runForTime(self) {
            let result = self.diceStack.roll()
            self.totalLabel.text = String(result)
            self.history.addRecord(dices: self.diceStack.dices, result: result)
        }
    }
    
}

/// Add 'ConfigurationDelegate' conformance.
extension MainViewController: ConfigurationDelegate {
    
    // updates Dices data. Called from ConfigurationVC
    func updateDices(diceSetArray: [DiceSet]) {
        diceStack.dices = []
        diceStack.dices = diceSetArray.map { $0.copy() as! DiceSet }
        // save Dices configuration data to UserDefaults
        diceStack.saveToUserDefaults()
        // update visual elements for Dices
        updateViewsForDiceConfiguration()
    }
    
}
