//
//  WeatherHelper.swift
//  Muaz_Weather
//
//  Created by Muaz on 2022-11-05.
//

import Foundation
import UIKit
import SwiftUI

class ProductQueryController : ObservableObject{
    
    //@Published var productDataQuery = [Product()]
    @Published var productDataQuery = Product()

    func fetchDataFromAPI(product : String){
        print("Fetching data from API called")
        guard let api = URL(string: "https://api.amzapi.com/v1/search?apikey=71f76370-d334-11ed-98bc-73205bb86f59&query=\(product)") else {
            print(#function, "Unable to obtain from string")
            return
        }
    
        
        let task = URLSession.shared.dataTask(with: api) { (data: Data?, response: URLResponse?, error) in
            
                
            if let error = error {
                print(#function, "Unable to establish network connection \(error)")
            } else {
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    if httpResponse.statusCode == 200 {
                        //200 response OK
                        DispatchQueue.global().async {
                            do{
                                
                                if(data != nil){
                                    
                                    if let jsonData = data {
                                        
    
                                        let decodedData = try JSONDecoder().decode(Product.self, from: jsonData)
                                        
                                        
                                        DispatchQueue.main.async {
                                            self.productDataQuery = decodedData
                                            
                                        }

                                    } else {
                                        print(#function, "Unable to obtain jsonData")
                                    }
                                    
                                } else {
                                    print(#function, "No data with response code 200")
                                }
                                
                            }catch let error {
                                print(error)
                            
                            }
                        }
                    }
                    
                } else {
                    print(#function, "Unable to recieve any response")
                }// else
                
            }//else
            
        }
        
        task.resume()
        
    }
    

    
}





