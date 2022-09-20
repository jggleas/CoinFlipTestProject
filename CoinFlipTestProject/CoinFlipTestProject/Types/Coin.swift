//
//  Coin.swift
//  CoinFlipTestProject
//
//  Created by Jacob Gleason on 9/18/22.
//

class Coin: CoinList {
    var coinId: Int
    var market_cap_rank: Int
    var thumb: String
    var small: String
    var large: String
    var slug: String
    var price_btc: Double
    
    private enum CodingKeys: String, CodingKey {
        case coinId
        case market_cap_rank
        case thumb
        case small
        case large
        case slug
        case price_btc
    }
    
    /// Creates a new instance by decoding from the given decoder.
    /// - Parameter decoder: The decoder to read data from.
    ///
    /// Decode and initialize a ``SplitcartModel`` object.
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        coinId = try container.decodeIfPresent(Int.self, forKey: .coinId) ?? -1
        market_cap_rank = try container.decodeIfPresent(Int.self, forKey: .market_cap_rank) ?? -1
        thumb = try container.decodeIfPresent(String.self, forKey: .thumb) ?? ""
        small = try container.decodeIfPresent(String.self, forKey: .small) ?? ""
        large = try container.decodeIfPresent(String.self, forKey: .large) ?? ""
        slug = try container.decodeIfPresent(String.self, forKey: .slug) ?? ""
        price_btc = try container.decodeIfPresent(Double.self, forKey: .price_btc) ?? -1
        try super.init(from: decoder)
    }
    
    init(id: String, symbol: String, name: String, coinId: Int, market_cap_rank: Int,
         thumb: String, small: String, large: String, slug: String, price_btc: Double) {
        self.coinId = coinId
        self.market_cap_rank = market_cap_rank
        self.thumb = thumb
        self.small = small
        self.large = large
        self.slug = slug
        self.price_btc = price_btc
        super.init(id: id, symbol: symbol, name: name)
    }
}
