//
//  HomepageModel.swift
//  Niyo Mart
//
//  Created by AppleMac on 31/10/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import Foundation

struct CategoryModel : Codable {
    let category_id : Int?
    let category_name : String?
    let category_image : String?
    
    enum CodingKeys: String, CodingKey {
        
        case category_id = "category_id"
        case category_name = "category_name"
        case category_image = "category_image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category_id = try values.decodeIfPresent(Int.self, forKey: .category_id)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        category_image = try values.decodeIfPresent(String.self, forKey: .category_image)
    }
    
}

struct ProductModel : Codable {
    let product_id : Int?
    let product_name : String?
    let product_detail : String?
    let product_actual_price : String?
    let product_discount : String?
    let product_final_price : String?
    let product_images : [Product_images]?
    
    enum CodingKeys: String, CodingKey {
        
        case product_id = "product_id"
        case product_name = "product_name"
        case product_detail = "product_detail"
        case product_actual_price = "product_actual_price"
        case product_discount = "product_discount"
        case product_final_price = "product_final_price"
        case product_images = "product_images"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        product_id = try values.decodeIfPresent(Int.self, forKey: .product_id)
        product_name = try values.decodeIfPresent(String.self, forKey: .product_name)
        product_detail = try values.decodeIfPresent(String.self, forKey: .product_detail)
        product_actual_price = try values.decodeIfPresent(String.self, forKey: .product_actual_price)
        product_discount = try values.decodeIfPresent(String.self, forKey: .product_discount)
        product_final_price = try values.decodeIfPresent(String.self, forKey: .product_final_price)
        product_images = try values.decodeIfPresent([Product_images].self, forKey: .product_images)
    }
    
}

struct Product_images : Codable {
    let image_id : Int?
    let product_id : Int?
    let product_image : String?
    
    enum CodingKeys: String, CodingKey {
        
        case image_id = "image_id"
        case product_id = "product_id"
        case product_image = "product_image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image_id = try values.decodeIfPresent(Int.self, forKey: .image_id)
        product_id = try values.decodeIfPresent(Int.self, forKey: .product_id)
        product_image = try values.decodeIfPresent(String.self, forKey: .product_image)
    }
    
}
