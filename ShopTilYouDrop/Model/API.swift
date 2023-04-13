//
//  API.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-04-04.
//

import Foundation
import UIKit

//struct Product: Codable {
//    let search_results: [Search_Result]
//    let request_meta_data: Request_Meta_Data
//
//    struct Request_Meta_Data: Codable {
//        let uuid: String
//        let total_time_taken: Double
//        let amazon_url: String
//
//    }
//
//    struct Search_Result: Codable {
//        let position: Int
//        let asin: String
//        let link: String
//        let title: String
//        let image: String
//        let prices: [Price]?
//        let rating: Rating
//
//
//
//        struct Price: Codable {
//            let symbol: String
//            let value: Double
//            let currency: String
//
//        }
//
//        struct Rating: Codable {
//            let raw: String
//            let count: Int
//            let value: Double
//            let out_of: Int
//
//        }
//
//    }
//
//
//    init(){
//        search_results = [Search_Result(position: 0, asin: "", link: "", title: "", image: "", prices: [Search_Result.Price(symbol: "", value: 0.0, currency: "")], rating: Search_Result.Rating(raw: "", count: 0, value: 0.0, out_of: 0))]
//
//       request_meta_data = Request_Meta_Data(uuid: "", total_time_taken: 0.0, amazon_url: "")
//    }
//
//}



        
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let product = try Product(json)



// MARK: - Product
struct Product : Codable{
    var status: String
    var request_id: String
    var data: [Datum]
    
    
    struct Datum : Codable {
        let product_id : String?
        let product_title : String?
        let product_description: String?
        let product_photos: [String]?
        let product_rating: Double?
        let product_page_url : String?
        let product_offers_page_url : String?
        let product_specs_page_url : String?
        let product_reviews_page_url: String?
        let product_num_reviews: Int?
        let typical_price_range: [String]?
        let offer: Offer
    }
    
    struct Offer : Codable {
        let store_name: String
        let store_rating: Double?
        let offer_page_url: String?
        let store_review_count: Int?
        let store_reviews_page_url: String?
        let price: String?
        let shipping: String?
        let tax: String?
        let on_sale: Bool?
        let product_condition: String?
    }

    init(){
        status = ""
        request_id = ""
        data = [Datum.init(product_id: "", product_title: "", product_description: "", product_photos: [""], product_rating: 0.0, product_page_url: "", product_offers_page_url: "", product_specs_page_url: "", product_reviews_page_url: "", product_num_reviews: 0, typical_price_range: [""], offer: Offer.init(store_name: "", store_rating: 0.0, offer_page_url: "", store_review_count: 0, store_reviews_page_url: "", price: "", shipping: "", tax: "", on_sale: false, product_condition: ""))]
    }
}



    

