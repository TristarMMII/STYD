//
//  API.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-04-04.
//

import Foundation
import UIKit



struct APIResponse: Codable{
        
    let search_results: [Search_results]
    
    struct Search_results: Codable{
        
        let title: String
    
        }
    
    
    init(){
        search_results = [Search_results].init(
            
        )
            
        }
        
    }
    
    
        

    

