//
//  SideMenuViewController.swift
//  SoleekLabsTask
//
//  Created by islam metwally on 8/19/19.
//  Copyright © 2019 Islam Metwally. All rights reserved.
//

import UIKit

protocol SideMenuViewContollerProtocol: class {
    var presenter: SideMenuPresenterProtocol? { get set }
    
    func reloadTableView()
    func didSelectIndex(_ indexPath: IndexPath)
}

class SideMenuViewController: UIViewController {

    var presenter: SideMenuPresenterProtocol?
    
    @IBOutlet weak var ordersContainer: UIView!
    @IBOutlet weak var detailsContainer: UIView!
    @IBOutlet weak var homeContainer: UIView!
    @IBOutlet weak var sideMenuButton: UIButton!
    @IBOutlet weak var menuTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPresenter()
        self.setupTableView()
    }
    
    func setupPresenter() {
        self.presenter = SideMenuPresenter()
        self.presenter?.view = self
    }

    @IBAction func menuDidTouchUpInside(_ sender: Any) {
        menuTableView.isHidden = !menuTableView.isHidden
    }
}

extension SideMenuViewController: SideMenuViewContollerProtocol {
    
    func reloadTableView() {
        self.menuTableView.reloadData()
    }
    
    func didSelectIndex(_ indexPath: IndexPath) {
        homeContainer.isHidden = true
        ordersContainer.isHidden = true
        detailsContainer.isHidden = true
        
        menuTableView.isHidden = true
        
        switch indexPath.row {
        case 0:
            homeContainer.isHidden = false
        case 1:
            ordersContainer.isHidden = false
        case 2:
            detailsContainer.isHidden = false
        case 3:
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = self.storyboard?.instantiateInitialViewController()
        default:
            homeContainer.isHidden = false
        }
        
        sideMenuButton.setTitle(self.presenter?.getTitleFor(indexPath), for: .normal)
    }
}


