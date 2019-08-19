//
//  LoginViewPresenter.swift
//  SoleekLabsTask
//
//  Created by islam metwally on 8/19/19.
//  Copyright © 2019 Islam Metwally. All rights reserved.
//

import Foundation

protocol LoginViewPresenterProtocol {
    var view: LoginViewController? { get set }
    
    func getPhoneCodes() -> [String]
}

class LoginViewPresenter: LoginViewPresenterProtocol {
    
    weak var view: LoginViewController?
    
    func getPhoneCodes() -> [String] {
        return ["🇪🇬(+20)", "🇧🇷(+70)", "🇧🇯(+30)"]
    }
}
