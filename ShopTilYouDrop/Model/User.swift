//
//  User.swift
//  ShopTilYouDrop
//
//  Created by Muaz on 2023-03-30.
//

import Foundation

import Foundation

class User: Identifiable{
    
    var wishList: [String]
    
    
    init(wishList: [String]){
        self.wishList = wishList
    }
    
}

