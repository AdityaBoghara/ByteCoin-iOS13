//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "4E90C776-FCC3-4B80-B73B-FD6816299E27"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        
        let urlString = "\(baseURL)/\(currency)/?apikey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let bitcoinPrice = parseJSON(safeData)
                }
            }
            
            task.resume()
            
        }
    }
    
    func parseJSON(_ data: Data) -> Double? {
        
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
            print(decodedData.rate)
            return decodedData.rate
        }catch{
            
            print(error)
            return nil
            
        }
    }

    
}
