//
//  CoinList.swift
//  CoinFlipTestProject
//
//  Created by Jacob Gleason on 9/17/22.
//

class CoinList: Codable {
    var id: String
    var symbol: String
    var name: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.symbol = try container.decodeIfPresent(String.self, forKey: .symbol) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
    
    init(id: String, symbol: String, name: String) {
        self.id = id
        self.symbol = symbol
        self.name = name
    }
}
