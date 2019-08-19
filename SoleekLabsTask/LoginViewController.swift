//
//  ViewController.swift
//  SoleekLabsTask
//
//  Created by islam metwally on 8/19/19.
//  Copyright © 2019 Islam Metwally. All rights reserved.
//

import UIKit
import iOSDropDown

protocol LoginViewControllerProtocol: class {
    var presenter: LoginViewPresenterProtocol? { get set }
}

class LoginViewController: UIViewController {

    @IBOutlet weak var phoneCodeSignUp: DropDown!
    @IBOutlet weak var phoneCodeLogin: DropDown!
    @IBOutlet weak var loginArrowImage: UIImageView!
    @IBOutlet weak var signupArrowImage: UIImageView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var signupView: UIView!
    
    var presenter: LoginViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPresenter()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupDropDown(phoneCodeSignUp)
        self.setupDropDown(phoneCodeLogin)
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
    @IBAction func LoginDidTouchUpInside(_ sender: Any) {
        self.shouldShowLogin(true)
    }
    
    @IBAction func signUpDidTouchUpInside(_ sender: Any) {
        self.shouldShowLogin(false)
    }
    @IBAction func loginButtonDidTouchUpInside(_ sender: Any) {
        self.presenter?.navigateToProductDetails()
    }
    @IBAction func signupButtonDidTouchUpInside(_ sender: Any) {
        self.presenter?.navigateToProductDetails()
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    
}

extension LoginViewController {
    private func shouldShowLogin(_ shouldShow: Bool) {
        self.loginArrowImage.isHidden = !shouldShow
        self.loginView.isHidden = !shouldShow
        self.signupView.isHidden = shouldShow
        self.signupView.isHidden = shouldShow
    }
}
