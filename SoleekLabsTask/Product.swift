//
//  Product.swift
//  SoleekLabsTask
//
//  Created by islam metwally on 8/19/19.
//  Copyright © 2019 Islam Metwally. All rights reserved.
//

import UIKit


class Category: NSObject {
    var id: Int!
    var name: String!
    var subCategory: Category?
    
    override init() {
        super.init()
    }
    
    init(_ category: [String: Any]) {
        super.init()
        self.id = category["id"] as? Int ?? 0
        self.name = category["name"] as? String ?? ""
        self.subCategory = Category()
        for cat in category["sub_categories"] as? [[String: Any]] ?? []{
            self.subCategory?.id = cat["id"] as? Int ?? 0
            self.subCategory?.name = cat["name"] as? String ?? ""
        }
    }
}

class Brand: NSObject {
    var id: Int!
    var updatedAt: Date!
    var name: String!
    var nameAr: String!
    var createdAt: Date!
    
    init(_ brand: [String: Any]) {
        super.init()
        self.id = brand["id"] as? Int ?? 0
        self.name = brand["name"] as? String ?? ""
        self.nameAr = brand["name_ar"] as? String ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH-mm-ss"
        self.updatedAt = dateFormatter.date(from: brand["updated_at"] as! String)
        self.createdAt = dateFormatter.date(from: brand["created_at"] as! String)
    }
}

class ProductDetails: NSObject {
    var isFavorite: Bool!
    var brand: Brand!
    var localDescription: String!
    var images: [String]!
    
    init(_ productDetails: [String: Any]) {
        super.init()
        self.isFavorite = productDetails["is_favourite"] as! Int != 0
        self.brand = Brand(productDetails["brand"] as! [String: Any])
        self.localDescription = productDetails["description"] as? String ?? ""
        self.images = []
        for image: String in productDetails["images"] as! [String] {
            self.images.append(image)
        }
    }
}

class Product: NSObject {
    
    var category: Category!
    var discountPrice: Double!
    var productDetails: ProductDetails!
    var id: Int!
    var price: Double!
    var isFavorite: Bool!
    var imageURL: URL!
    var localDescription: String!
    var name: String!
    var similarProducts: [Product]!
    var itemCount: Int = 0
    
    init(_ productJson: [String: Any]) {
        super.init()
        if let product = productJson["product"] as? [String: Any] {
            self.category = Category(product["category"] as! [String: Any])
            self.discountPrice = product["discount_price"] as? Double ?? 0.0
            self.productDetails = ProductDetails(product["details"] as! [String: Any])
            self.id = product["id"] as? Int ?? 0
            self.price = product["price"] as? Double ?? 0.0
            self.isFavorite = product["is_favourite"] as! Int != 0
            self.imageURL = URL(string: product["image"] as! String)
            self.localDescription = product["description"] as? String ?? ""
            self.name = product["name"] as? String ?? ""
        }
        self.similarProducts = []
        for similarProduct: [String: Any] in productJson["similar_products"] as! [[String: Any]]{
            let prod = Product(similarProduct)
            self.similarProducts.append(prod)
        }
    }
}
