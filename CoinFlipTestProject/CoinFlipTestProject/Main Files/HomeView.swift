//
//  HomeView.swift
//  CoinFlipTestProject
//
//  Created by Jacob Gleason on 9/18/22.
//

import UIKit

class HomeView: UIView {
    var tableViewHeightAnchor: NSLayoutConstraint!
    
    // MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundImage)
        addSubview(title)
        addSubview(tableView)
        addSubview(refreshButton)
        addSubview(poweredByContainer)
        
        addConstraints([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.heightAnchor.constraint(equalToConstant: 160),
            
            title.widthAnchor.constraint(equalToConstant: 200),
            title.heightAnchor.constraint(equalToConstant: 35),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -38),
            
            tableView.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            refreshButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            refreshButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            refreshButton.heightAnchor.constraint(equalToConstant: 45),
            
            poweredByContainer.topAnchor.constraint(equalTo: refreshButton.bottomAnchor, constant: 15),
            poweredByContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            poweredByContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            poweredByContainer.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Loader Functions
    func startLoading() {
        addSubview(loader)
        addConstraints([
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        loader.layer.shadowColor = UIColor.black.cgColor
        loader.layer.shadowOpacity = 0.2
        loader.layer.shadowOffset = CGSize(width: 2, height: 2)
        loader.layer.shadowRadius = 5
        layoutIfNeeded()
    }
    
    func stopLoading() {
        loader.removeFromSuperview()
        layoutIfNeeded()
    }
    
    // MARK: - View Variables
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cryptoCoins")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.systemBackground
        label.text = "Trending Coins"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return tableView
    }()
    
    lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.systemGreen
        button.setTitle("Refresh Trending Coins", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var poweredByContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let poweredByLabel = UILabel()
        poweredByLabel.translatesAutoresizingMaskIntoConstraints = false
        poweredByLabel.text = "Powered by CoinGecko"
        poweredByLabel.font = UIFont.systemFont(ofSize: 14)
        poweredByLabel.textColor = UIColor.secondaryLabel
        
        let coinGeckoImage = UIImageView()
        coinGeckoImage.translatesAutoresizingMaskIntoConstraints = false
        coinGeckoImage.image = UIImage(named: "coinGeckoLogo")!
        coinGeckoImage.contentMode = .scaleAspectFit
        
        view.addSubview(poweredByLabel)
        view.addSubview(coinGeckoImage)
        view.addConstraints([
            poweredByLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            poweredByLabel.trailingAnchor.constraint(equalTo: coinGeckoImage.leadingAnchor, constant: -10),
            poweredByLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            coinGeckoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coinGeckoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            coinGeckoImage.widthAnchor.constraint(equalToConstant: 18),
            coinGeckoImage.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        return view
    }()
    
    lazy var loader: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        let loadingView = UIActivityIndicatorView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Loading..."
        label.textAlignment = .center
        
        view.addSubview(loadingView)
        view.addSubview(label)
        
        view.addConstraints([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            loadingView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -10),
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.layer.cornerRadius = 5
        loadingView.startAnimating()
        
        return view
    }()
}
