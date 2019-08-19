//
//  LoginViewPresenter.swift
//  SoleekLabsTask
//
//  Created by islam metwally on 8/19/19.
//  Copyright © 2019 Islam Metwally. All rights reserved.
//

import Foundation

protocol LoginViewPresenterProtocol {
    var view: LoginViewControllerProtocol? { get set }
    
    func navigateToProductDetails()
    func getPhoneCodes() -> [String]
}

class LoginViewPresenter: LoginViewPresenterProtocol {
    
    weak var view: LoginViewControllerProtocol?
    
    func getPhoneCodes() -> [String] {
        return ["🇪🇬(+20)", "🇧🇷(+70)", "🇧🇯(+30)"]
    }
    
    func navigateToProductDetails() {
        if let view = view as? LoginViewController {
//            view.navigationController?.show(<#T##vc: UIViewController##UIViewController#>, sender: <#T##Any?#>)
        }
    }
}
