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


//class ProductQueryController : ObservableObject{
//
//    @Published var productData = [Product()]
//
//    let group = DispatchGroup()
//    //@Published var productDataQuery = Product()
//
//    func fetchProductData(for product: String, completion: @escaping (Result<Product, Error>) -> Void) {
//            guard let url = URL(string: "https://api.amzapi.com/v1/search?apikey=40ad5530-d428-11ed-b110-05c5eb371804&query=\(product)") else {
//                completion(.failure(NetworkError.invalidURL))
//                return
//            }
//
//            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//                if let error = error {
//                    completion(.failure(error))
//                    return
//                }
//
//                guard let httpResponse = response as? HTTPURLResponse else {
//                    completion(.failure(NetworkError.invalidResponse))
//                    return
//                }
//
//                guard (200..<300).contains(httpResponse.statusCode) else {
//                    completion(.failure(NetworkError.statusCode(httpResponse.statusCode)))
//                    return
//                }
//
//                guard let data = data else {
//                    completion(.failure(NetworkError.emptyData))
//                    return
//                }
//
//                do {
//                    let decoder = JSONDecoder()
//                    let product = try decoder.decode(Product.self, from: data)
//                    self?.productData.append(product)
//                    completion(.success(product))
//                } catch {
//                    completion(.failure(error))
//                }
//            }.resume()
//        }
//
//
//    func getSpecificProductData(index : Int) -> Product{
//        return productData[index]
//    }
//
//}

class ProductQueryController : ObservableObject {
    
    @Published var productData = [Product]()
    
    func fetchProductData(for product: String, completion: @escaping (Result<Product, Error>) -> Void) {
        guard let url = URL(string: "https://api.amzapi.com/v1/search?apikey=23ad2900-d48f-11ed-8624-557ed054ab15&query=\(product)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
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
                    self?.productData.append(product)
                }
                completion(.success(product))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getSpecificProductData(index: Int, completion: @escaping (Result<Product, Error>) -> Void) {
        if index < productData.count {
            let product = productData[index]
            completion(.success(product))
        } else {
            let error = NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Product data not available yet"])
            completion(.failure(error))
        }
    }
    
    func removeProduct(at index: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        if index < productData.count {
            productData.remove(at: index)
            completion(.success(()))
        } else {
            let error = NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Index out of range"])
            completion(.failure(error))
        }
    }

}






