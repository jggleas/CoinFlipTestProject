//
//  TrendingSortType.swift
//  CoinFlipTestProject
//
//  Created by Jacob Gleason on 9/20/22.
//

import Foundation

enum TrendingSortType: String {
    case score = "Trending Rank"
    case rank = "Market Cap Rank"
    case nameUp = "Name (A to Z)"
    case nameDown = "Name (Z to A)"
    case priceLow = "Price (Low to High)"
    case priceHigh = "Price (High to Low)"
}
