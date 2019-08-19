//
//  DetailsPresenter.swift
//  SoleekLabsTask
//
//  Created by islam metwally on 8/19/19.
//  Copyright © 2019 Islam Metwally. All rights reserved.
//

import Foundation

protocol DetailsPresenterProtocol {
    var view: DetailsViewControllerProtocol? { get set }
    var product: Product! { get set }
    
    func fetchProductDetails()
    func getNumberOfSimilarItems() -> Int
    func getProduct(at indexPath: IndexPath) -> Product
}

class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: DetailsViewControllerProtocol?
    let productOperation = ProductOperation()
    var observerIndex: Int = -1
    var product: Product!
    
    func fetchProductDetails() {
        
        let operationQueue: OperationQueue = OperationQueue()
        self.observerIndex = productOperation.addObserver(self)
        operationQueue.addOperation(productOperation)
    }
    
    func getNumberOfSimilarItems() -> Int {
        return product.similarProducts.count
    }
    
    func getProduct(at indexPath: IndexPath) -> Product {
        return product.similarProducts[indexPath.row]
    }
}

extension DetailsPresenter:ProductOpertionDelegate {
    
    func didFetchDetails(_ product: Product) {
        self.product = product
        DispatchQueue.main.async {
            self.view?.didFetchProduct(product)
            self.productOperation.removeObserver(at: self.observerIndex)
        }
    }
    
    func didFailFetchDetails(_ error: String) {
        DispatchQueue.main.async {
            self.view?.didFailFetchProduct(error)
            self.productOperation.removeObserver(at: self.observerIndex)
        }
    }
}

extension DetailsPresenter: similarProductCellDelegate {
    func didAddProduct(at indexPath: IndexPath) {
        let tempProduct = self.product.similarProducts[indexPath.row]
        tempProduct.itemCount += 1
        self.view?.updateCell(at: indexPath, product: tempProduct)
        self.view?.didAddSimilarProduct(indexPath)
    }
    
    func didremoveProduct(at indexPath: IndexPath) {
        let tempProduct = self.product.similarProducts[indexPath.row]
        tempProduct.itemCount -= 1
        self.view?.updateCell(at: indexPath, product: tempProduct)
    }
}
