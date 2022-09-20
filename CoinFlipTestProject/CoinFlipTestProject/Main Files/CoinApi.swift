//
//  CoinApi.swift
//  CoinFlipTestProject
//
//  Created by Jacob Gleason on 9/17/22.
//

import Foundation

@objc protocol CoinApiObservers: AnyObject {
    @objc func loaded(_ notification: Notification)
}

class CoinApi {
    static let shared = CoinApi()
    
    // Loading Variables
    var loadingCoins: Bool = true {
        didSet { if !loadingCoins { sendLoadedNotification() } }
    }
    var loadingTrending: Bool = true {
        didSet { if !loadingTrending { sendLoadedNotification() } }
    }
    var loadingBitcoin: Bool = true {
        didSet { if !loadingBitcoin { sendLoadedNotification() } }
    }
    var loadingPrices: Bool = true {
        didSet { if !loadingPrices { sendLoadedNotification() } }
    }
    
    // Error Variables
    var bitcoinError: Bool = false
    var coinError: Bool = false
    var trendingError: Bool = false
    var pricesError: Bool = false
    
    // Coin Variables
    var coins: [CoinList] = []
    var trending: [Coin] = []
    var trendingPrices: [Double] = []
    var bitcoinPrice: Double = -1
    
    private init() { }
    deinit { reset() }
    
    func setup() {
        getBitcoinPrice()
        getCoinList()
        getTrendingCoins()
    }
    
    func refresh() {
        getBitcoinPrice()
        getTrendingCoins()
    }
    
    func reset() {
        coins = []
    }
    
    private func sendLoadedNotification() {
        NotificationCenter.default.post(name: Notification.Name("Loaded"), object: nil)
    }
    
    private func getBitcoinPrice() {
        grabDataFromRequest(query: "simple/price?ids=bitcoin&vs_currencies=usd") { [weak self] (data, status, error) in
            guard let self = self else { return }
            
            struct Parent: Decodable {
                var bitcoin: Child
            }
            
            struct Child: Decodable {
                var usd: Double
            }
            
            if let data = data, let bitcoinPrice = try? JSONDecoder().decode(Parent.self, from: data) {
                self.bitcoinPrice = bitcoinPrice.bitcoin.usd
            }
        }
    }
    
    private func getCoinList() {
        loadingCoins = true
        grabDataFromRequest(query: "coins/list") { [weak self] (data, status, error) in
            guard let self = self else { return }
            
            if let data = data, let coinData = try? JSONDecoder().decode([CoinList].self, from: data) {
                self.coins = coinData
            } else {
                self.coinError = true
            }
            self.loadingCoins = false
        }
    }
    
    private func getTrendingCoins() {
        loadingTrending = true
        grabDataFromRequest(query: "search/trending") { [weak self] (data, status, error) in
            guard let self = self else { return }
            
            struct Parent: Decodable {
                var coins: [Child]
            }
            
            struct Child: Decodable {
                var item: Coin
            }
            
            if let data = data, let coinData = try? JSONDecoder().decode(Parent.self, from: data) {
                self.trending = coinData.coins.map({ $0.item })
            } else {
                self.coinError = true
            }
            self.loadingTrending = false
        }
    }
    
    private func getTrendingPrices() {
        loadingPrices = true
    }
    
    /// Grab the resulting data from a `URLRequest` with the given parameters.
    /// - Parameters:
    ///   - method: The HTTP method to of which to make the request. The default is `GET`.
    ///   - query: The url query of the request.
    ///   - body: The HTTP body data of the request. The default is `nil`.
    ///   - complete: A block that is called once the result is available. The block takes a `Data?` parameter containing the response data, if applicable,
    ///   an `Int` parameter containing the status code of the response, and an `Error?` parameter containing an error, if one occurred during the request.
    private func grabDataFromRequest(method: String = "GET", query: String, body: Data? = nil, complete: @escaping(Data?, Int, Error?) -> Void) {
        let url = "https://api.coingecko.com/api/v3/" + query
        if let ecommerceURL = URL(string: url) {
            var request = URLRequest(url: ecommerceURL)
            request.httpMethod = method
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = body
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                complete(data, (response as? HTTPURLResponse)?.statusCode ?? -500, error)
            }
            task.resume()
        }
    }
}
