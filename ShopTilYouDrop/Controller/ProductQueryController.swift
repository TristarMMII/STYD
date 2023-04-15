//
//  WeatherHelper.swift
//  Muaz_Weather
//
//  Created by Muaz on 2022-11-05.
//https://www.freecodecamp.org/news/how-to-make-your-first-api-call-in-swift/

import Foundation
import UIKit
import SwiftUI
import Network

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case emptyData
}


class ProductQueryController : ObservableObject {
    
    @Published var productData = [Product]()
    
    func fetchProductData(for product: String, completion: @escaping (Result<Product, Error>) -> Void) {
        
        let headers = [            "X-RapidAPI-Key": "f78ec949c9msh56530a588aa61f8p1a1246jsn843e6d48ab6f",            "X-RapidAPI-Host": "real-time-product-search.p.rapidapi.com"        ]
        
        guard let url = URL(string: "https://real-time-product-search.p.rapidapi.com/search?q=\(product)&country=us&language=en") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.statusCode(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let product = try decoder.decode(Product.self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.productData.append(product) // add product to a new index in productData
                }
                completion(.success(product))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getSpecificProductData(index: Int, completion: @escaping (Result<Product.Datum, Error>) -> Void) {
        if index < productData[index].data.count {
            if(productData[index].data != nil){
                let product = productData[index].data
                completion(.success(product[index]))
            }
        } else {
            let error = NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Product data not available yet"])
            completion(.failure(error))
        }
    }
    
    func removeProduct(at index: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        if index < productData[index].data.count {
            productData[index].data.remove(at: index)
            completion(.success(()))
        } else {
            let error = NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Index out of range"])
            completion(.failure(error))
        }
    }

}
