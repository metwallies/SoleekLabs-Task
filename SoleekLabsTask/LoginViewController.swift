//
//  ViewController.swift
//  SoleekLabsTask
//
//  Created by islam metwally on 8/19/19.
//  Copyright © 2019 Islam Metwally. All rights reserved.
//

import UIKit
import iOSDropDown

class LoginViewController: UIViewController {

    @IBOutlet weak var phoneCodeSignUp: DropDown!
    
    var presenter: LoginViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPresenter()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupDropDown(phoneCodeSignUp)
    }
    
    func setupPresenter() {
        self.presenter = LoginViewPresenter()
        self.presenter?.view = self
    }
    
    func setupDropDown(_ dropDown: DropDown) {
        dropDown.optionArray = self.presenter?.getPhoneCodes() ?? []
        dropDown.arrowColor = .clear
        dropDown.selectedRowColor = .clear
    }


}

