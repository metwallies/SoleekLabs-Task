//
//  ProductOperation.swift
//  SoleekLabsTask
//
//  Created by islam metwally on 8/19/19.
//  Copyright © 2019 Islam Metwally. All rights reserved.
//

import Foundation

protocol ProductOpertionDelegate {
    func didFetchDetails(_ product: Product, productOperation: ProductOperation)
    func didFailFetchDetails(_ error: String, productOperation: ProductOperation)
}

class ProductOperation: Operation {
    private var observers: [ProductOpertionDelegate] = []
    
    func addObserver(_ observer: ProductOpertionDelegate) -> Int {
        self.observers.append(observer)
        return self.observers.count - 1
    }
    
    func removeObserver(at index: Int) {
        self.observers.remove(at: index)
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        self.fetchProductDetails()
    }
    
    private func fetchProductDetails() {
        let url = URL(string: Constants.API)!
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(Constants.Bearer, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, res, error) in
            if let error = error {
                for observer in self.observers {
                    observer.didFailFetchDetails(error.localizedDescription, productOperation: self)
                }
            } else {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        let dataJson = json as! [String: Any]
                        let productJson = dataJson["data"] as! [String: Any]
                        let product = Product(productJson)
                        if self.isCancelled {
                            return
                        }
                        for observer in self.observers {
                            observer.didFetchDetails(product, productOperation: self)
                        }
                    } catch let error {
                        if self.isCancelled {
                            return
                        }
                        for observer in self.observers {
                            observer.didFailFetchDetails(error.localizedDescription, productOperation: self)
                        }
                    }
                }
            }
        }
        task.resume()
    }
}
