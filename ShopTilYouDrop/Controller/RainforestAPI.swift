//
//  WeatherHelper.swift
//  Muaz_Weather
//
//  Created by Muaz on 2022-11-05.
//

import Foundation
import UIKit
import SwiftUI

class WeatherHelper : ObservableObject{
    
    @Published var weather = APIResponse()
    
    init() {
        self.fetchDataFromAPI()
    }
    
    func fetchDataFromAPI(){
        print("Fetching data from API called")
        guard let api = URL(string: "https://api.amzapi.com/v1/search?apikey=71f76370-d334-11ed-98bc-73205bb86f59&query=mouse") else {
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
                                        
    
                                        let decodedWeatherList = try JSONDecoder().decode(APIResponse.self, from: jsonData)
                                        
                                        
                                        DispatchQueue.main.async {
                                            self.weather = decodedWeatherList
                                            
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





