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
