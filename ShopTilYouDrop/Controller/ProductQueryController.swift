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


class ProductQueryController : ObservableObject{
    
    @Published var productData = [Product()]
    
    let group = DispatchGroup()
    //@Published var productDataQuery = Product()
    
    func fetchProductData(for product: String, completion: @escaping (Result<Product, Error>) -> Void) {
            guard let url = URL(string: "https://api.amzapi.com/v1/search?apikey=40ad5530-d428-11ed-b110-05c5eb371804&query=\(product)") else {
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
                    self?.productData.append(product)
                    completion(.success(product))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }


//    func fetchDataFromAPI(product : String){
//        print("Fetching data from API called")
//        guard let api = URL(string: "https://api.amzapi.com/v1/search?apikey=40ad5530-d428-11ed-b110-05c5eb371804&query=\(product)") else {
//            print(#function, "Unable to obtain from string")
//            return
//        }
//
//
//        let task = URLSession.shared.dataTask(with: api) { (data: Data?, response: URLResponse?, error) in
//
//
//            if let error = error {
//                print(#function, "Unable to establish network connection \(error)")
//            } else {
//
//                if let httpResponse = response as? HTTPURLResponse {
//
//                    if httpResponse.statusCode == 200 {
//                        //200 response OK
//                        DispatchQueue.global().async {
//                            do{
//
//                                if(data != nil){
//
//                                    if let jsonData = data {
//
//
//                                        let decodedData = try JSONDecoder().decode(Product.self, from: jsonData)
//
//
//                                        DispatchQueue.main.async{
//                                            self.productData.append(decodedData)
//
//                                        }
//
//                                    } else {
//                                        print(#function, "Unable to obtain jsonData")
//                                    }
//
//                                } else {
//                                    print(#function, "No data with response code 200")
//                                }
//
//                            }catch let error {
//                                print(error)
//
//                            }
//                        }
//                    }
//
//                } else {
//                    print(#function, "Unable to recieve any response")
//                }// else
//
//            }//else
//
//        }
//
//        task.resume()
//    }
    
//    func fetchDataFromAPII(product : String, withCompletion completion: @escaping (Product?) -> Void){
//        print("Fetching data from API called")
//
//        guard let api = URL(string: "https://api.amzapi.com/v1/search?apikey=71f76370-d334-11ed-98bc-73205bb86f59&query=\(product)") else {
//            print(#function, "Unable to obtain from string")
//            return
//        }
//
//        print(#function, api)
//
//        let task = URLSession.shared.dataTask(with: api){ (data: Data?, response: URLResponse?, error: Error?) in
//            if let error = error{
//                print(#function,"Unable to Establish network connection : \(error)")
//            }else{
//                if let httpResponse = response as? HTTPURLResponse{
//                    if httpResponse.statusCode == 200{
//                        //Response OK
//
//                        DispatchQueue.global().async {
//                            do{
//                                if(data != nil){
//                                    if let jsonData = data{
//                                        //performing decoding
//                                        let decoder = JSONDecoder()
//
//                                        //decoder tries to find single object
//                                        //note for assignment 3 we need data from a single object, we wont need an array of Json objects
//                                        let decodedData = try decoder.decode(Product.self, from: jsonData)
//                                        print(#function, decodedData)
//
//                                        DispatchQueue.main.async {
//                                            self.productData.append(decodedData)
//                                            completion(decodedData)
//                                        }
//
//
//
//                                    }else{
//                                        print(#function,"Unable to obtiain Json Data")
//                                    }
//                                }else{
//                                    print(#function,"No Data with response code 200")
//                                }
//                            }catch let error{
//                                print(#function,"No Data Recived \(error)")
//                            }
//                        }
//
//                    }else{
//                        print(#function,"HTTP response status code : \(httpResponse.statusCode)")
//                    }
//
//                }else{
//                    print(#function,"Unable to obtiain any response from network call")
//                }//else
//            }//else
//        }//URLSession
//        task.resume()
//    }
    
    func getSpecificProductData(index : Int) -> Product{
        
        
        
        
        
        return productData[index]
    }
    
}





