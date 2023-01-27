//
//  QuoteApiManager.swift
//  Watudo
//
//  Created by Sebastian Hajduk on 26/01/2023.
//

import Foundation
import Alamofire

struct QuoteApiManager {
    
    static func makeRequest() async -> Quote? {
        let dataTask = AF.request("https://zenquotes.io/api/random")
        let decoded = dataTask.serializingDecodable([Quote].self)
        let response = await decoded.response
        let result = response.result
        
        switch result {
        case .success(let quotes):
            return quotes[0]
        case .failure(let failure):
            print("Error: \(failure)")
            return nil
        }
   }
}
