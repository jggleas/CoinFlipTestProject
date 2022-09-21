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
    var score: Int
    
    private enum CodingKeys: String, CodingKey {
        case coinId
        case market_cap_rank
        case thumb
        case small
        case large
        case slug
        case price_btc
        case score
    }
    
    /// Creates a new instance by decoding from the given decoder.
    /// - Parameter decoder: The decoder to read data from.
    ///
    /// Decode and initialize a ``Coin`` object.
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        coinId = try container.decodeIfPresent(Int.self, forKey: .coinId) ?? -1
        market_cap_rank = try container.decodeIfPresent(Int.self, forKey: .market_cap_rank) ?? -1
        thumb = try container.decodeIfPresent(String.self, forKey: .thumb) ?? ""
        small = try container.decodeIfPresent(String.self, forKey: .small) ?? ""
        large = try container.decodeIfPresent(String.self, forKey: .large) ?? ""
        slug = try container.decodeIfPresent(String.self, forKey: .slug) ?? ""
        price_btc = try container.decodeIfPresent(Double.self, forKey: .price_btc) ?? -1
        score = try container.decodeIfPresent(Int.self, forKey: .score) ?? -1
        try super.init(from: decoder)
    }
}
