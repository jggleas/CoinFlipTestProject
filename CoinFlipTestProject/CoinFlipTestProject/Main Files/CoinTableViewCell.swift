//
//  CoinTableViewCell.swift
//  CoinFlipTestProject
//
//  Created by Jacob Gleason on 9/18/22.
//

import UIKit

class CoinTableViewCell: UITableViewCell {
    static var reuseId = "CoinCell"
    
    // MARK: - Initialization and Configuration
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        addSubview(coinImageView)
        addSubview(nameLabel)
        addSubview(symbolLabel)
        addSubview(marketCapRankLabel)
        addSubview(priceView)
        addSubview(priceLabel)
        addConstraints([
            coinImageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            coinImageView.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: -12),
            coinImageView.widthAnchor.constraint(equalToConstant: 25),
            coinImageView.heightAnchor.constraint(equalToConstant: 25),
            coinImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: symbolLabel.leadingAnchor, constant: -4),
            
            symbolLabel.trailingAnchor.constraint(lessThanOrEqualTo: priceView.leadingAnchor, constant: -12),
            symbolLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            
            marketCapRankLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            marketCapRankLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 12),
            
            priceView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            priceView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: priceView.topAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: priceView.trailingAnchor, constant: -10),
            priceLabel.bottomAnchor.constraint(equalTo: priceView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(coin: Coin) {
        coinImageView.loadImage(urlString: coin.small)
        nameLabel.text = coin.name
        symbolLabel.text = "(\(coin.symbol))"
        marketCapRankLabel.text = "Market Cap Rank: \(coin.market_cap_rank)"
        let divisor = pow(10.0, Double(7))
        let price = (coin.price_btc * CoinApi.shared.bitcoinPrice * divisor).rounded() / divisor
        priceLabel.text = "$\(price)"
    }
    
    // MARK: - Varaibles
    lazy var coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    lazy var marketCapRankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var priceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        return label
    }()
}
