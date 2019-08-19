//
//  SideMenuViewControllerPresenter.swift
//  SoleekLabsTask
//
//  Created by islam metwally on 8/19/19.
//  Copyright © 2019 Islam Metwally. All rights reserved.
//

import Foundation

protocol SideMenuPresenterProtocol {
    var view: SideMenuViewContollerProtocol? { get set }
    
    func getNumberOfRows() -> Int
    func getSelectedIndex() -> IndexPath
    func didSelectIndex(_ index: IndexPath)
    func getTitleFor(_ index: IndexPath) -> String
}

class SideMenuPresenter: SideMenuPresenterProtocol {
    
    weak var view: SideMenuViewContollerProtocol?
    var selectedIndex: IndexPath = IndexPath(row: 0, section: 0)
    var titles: [String] = ["Home", "Orders", "Details", "Logout"]
    
    func getNumberOfRows() -> Int {
        return 4
    }
    
    func getSelectedIndex() -> IndexPath {
        return selectedIndex
    }
    
    func didSelectIndex(_ index: IndexPath) {
        self.selectedIndex = index
        self.view?.reloadTableView()
        self.view?.didSelectIndex(index)
    }
    
    func getTitleFor(_ index: IndexPath) -> String {
        return titles[index.row]
    }
}
