//
//  CoinViewController.swift
//  CoinFlipTestProject
//
//  Created by Jacob Gleason on 9/20/22.
//

import UIKit

class CoinViewController: UIViewController {
    private let coinView = CoinView()
    private var coin: Coin
    
    init(for coin: Coin) {
        self.coin = coin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not using Storyboards")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(coinView)
        
        coinView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        coinView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        coinView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        coinView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        coinView.coinImageView.loadImage(urlString: coin.large)
        coinView.nameLabel.text = coin.name
        coinView.symbolLabel.text = "(\(coin.symbol))"
        let divisor = pow(10.0, Double(10))
        let price = (coin.price_btc * CoinApi.shared.bitcoinPrice * divisor).rounded() / divisor
        coinView.priceLabel.text = "$\(price)"
        coinView.trendingRankLabel.text = "Trending Rank: \(trendingRank(for: coin.score))"
        coinView.marketCapRankLabel.text = "Market Cap Rank: \(coin.market_cap_rank)"
        coinView.backButton.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
    }
    
    private func trendingRank(for score: Int) -> String {
        switch score {
        case 0:
            return "First"
        case 1:
            return "Second"
        case 2:
            return "Third"
        case 3:
            return "Fourth"
        case 4:
            return "Fifth"
        case 5:
            return "Sixth"
        case 6:
            return "Last"
        default:
            return ""
        }
    }
    
    @objc func goBack(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
