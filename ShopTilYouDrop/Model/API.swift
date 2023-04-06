//
//  API.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-04-04.
//

import Foundation
import UIKit

struct Product: Codable {
    let search_results: [Search_Result]
    let request_meta_data: Request_Meta_Data

    struct Request_Meta_Data: Codable {
        let uuid: String
        let total_time_taken: Double
        let amazon_url: String

    }
    
    struct Search_Result: Codable {
        let position: Int
        let asin: String
        let link: String
        let title: String
        let image: String
        let prices: [Price]?
        let rating: Rating

        
        
        struct Price: Codable {
            let symbol: String
            let value: Double
            let currency: String
            
        }
        
        struct Rating: Codable {
            let raw: String
            let count: Int
            let value: Double
            let out_of: Int

        }
        
    }
    
    
    init(){
        search_results = [Search_Result(position: 0, asin: "", link: "", title: "", image: "", prices: [Search_Result.Price(symbol: "", value: 0.0, currency: "")], rating: Search_Result.Rating(raw: "", count: 0, value: 0.0, out_of: 0))]
        
       request_meta_data = Request_Meta_Data(uuid: "", total_time_taken: 0.0, amazon_url: "")
    }
    
}

        
//struct Product: Codable{
//
//    let searchResults: [SearchResults]
//
//    struct SearchResults: Codable{
//
//        let title: String
//
//        }
//
//
//    init(){
//        searchResults = [SearchResults].init(
//
//        )
//
//        }
//
//    }

    

