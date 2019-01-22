//
//  DialogFlowViewController.swift
//  DFSampleUI
//
//  Created by Santhosh Vaddi on 1/20/19.
//  Copyright © 2019 Santhosh Vaddi. All rights reserved.
//

import UIKit
import MaterialComponents

let selfKey = "self"
let botKey  = "Bot"

class DialogFlowViewController: UIViewController {
    var appBar = MDCAppBar()
    // Text Field
    var intentTextField: MDCTextField = {
        let usernameTextField = MDCTextField()
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.clearButtonMode = .unlessEditing;
        return usernameTextField
    }()
    var  textFieldBottomConstraint: NSLayoutConstraint!
    let intentTextFieldController: MDCTextInputControllerOutlined
    var tableViewDataSource = [[String: String]]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var optionsCard: MDCCard!
    @IBOutlet weak var audioButton: UIButton!
    @IBOutlet weak var keybordButton: UIButton!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        intentTextFieldController = MDCTextInputControllerOutlined(textInput: intentTextField)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        intentTextFieldController.placeholderText = "Type your intent"
        intentTextField.delegate = self
        
        registerKeyboardNotifications()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        intentTextFieldController = MDCTextInputControllerOutlined(textInput: intentTextField)
        
        super.init(coder: aDecoder)
        intentTextFieldController.placeholderText = "Type your intent"
        
        intentTextField.delegate = self
        registerKeyboardNotifications()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.tintColor = .black
        self.view.backgroundColor = ApplicationScheme.shared.colorScheme
            .surfaceColor
        self.title = "Dialog Flow"
        setUpNavigationBarAndItems()
        optionsCard.cornerRadius = optionsCard.frame.height/2
        self.view.addSubview(intentTextField)
        intentTextField.isHidden = true
        intentTextField.backgroundColor = .white
        intentTextField.returnKeyType = .send
        textFieldBottomConstraint = NSLayoutConstraint(item: intentTextField,
                                                       attribute: .bottom,
                                                       relatedBy: .equal,
                                                       toItem: view,
                                                       attribute: .bottom,
                                                       multiplier: 1,
                                                       constant: 0)
        // Constraints
        var constraints = [NSLayoutConstraint]()
        constraints.append(textFieldBottomConstraint)
        constraints.append(contentsOf:
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-[intentTF]-|",
                                           options: [],
                                           metrics: nil,
                                           views: [ "intentTF" : intentTextField]))
        NSLayoutConstraint.activate(constraints)
        let colorScheme = ApplicationScheme.shared.colorScheme
        MDCTextFieldColorThemer.applySemanticColorScheme(colorScheme,
                                                         to: self.intentTextFieldController)
    }
    
    func setUpNavigationBarAndItems() {
        // AppBar Init
        self.addChild(appBar.headerViewController)
        self.appBar.headerViewController.headerView.trackingScrollView = tableView
        appBar.addSubviewsToParent()
        MDCAppBarColorThemer.applySemanticColorScheme(ApplicationScheme.shared.colorScheme, to:self.appBar)
        
        // Setup Navigation Items
        let menuItemImage = UIImage(named: "Keypad")
        let templatedMenuItemImage = menuItemImage?.withRenderingMode(.alwaysTemplate)
        let menuItem = UIBarButtonItem(image: templatedMenuItemImage,
                                       style: .plain,
                                       target: nil,
                                       action: nil)
        //        self.navigationItem.leftBarButtonItem = menuItem
        
        let tuneItemImage = UIImage(named: "Mic")
        let templatedTuneItemImage = tuneItemImage?.withRenderingMode(.alwaysTemplate)
        let tuneItem = UIBarButtonItem(image: templatedTuneItemImage,
                                       style: .plain,
                                       target: nil,
                                       action: nil)
        //        self.navigationItem.rightBarButtonItem = tuneItem
    }
    
    @IBAction func didTapkeyboard(_ sender: Any) {
        //make intentTF first responder
        //make intentTF inputAccessoryView
        intentTextField.isHidden = false
        intentTextField.becomeFirstResponder()
    }
    
}

extension DialogFlowViewController {
    // MARK: - Keyboard Handling
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow),
            name: NSNotification.Name(rawValue: "UIKeyboardWillShowNotification"),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow),
            name: NSNotification.Name(rawValue: "UIKeyboardWillChangeFrameNotification"),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide),
            name: NSNotification.Name(rawValue: "UIKeyboardWillHideNotification"),
            object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardFrame =
            (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        textFieldBottomConstraint.constant = -keyboardFrame.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        textFieldBottomConstraint.constant = 0
        intentTextField.isHidden = true
        
    }
}

extension DialogFlowViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text, text.count > 0 {
            tableViewDataSource.append([selfKey: text])
            tableViewDataSource.append([botKey: "Sorry, come again."])
            tableView.reloadData()
            textField.text = ""
        }
        
        return true
    }
}


extension DialogFlowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tableViewDataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: data[selfKey] != nil ? "selfCI" : "intentCI", for: indexPath) as! ChatTableViewCell
        if data[selfKey] != nil {
            cell.selfText.text = data[selfKey]
        } else {
            cell.botResponseText.text = data[botKey]
        }
        return cell
    }
}

