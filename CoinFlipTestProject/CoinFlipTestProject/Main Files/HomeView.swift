//
//  HomeView.swift
//  CoinFlipTestProject
//
//  Created by Jacob Gleason on 9/18/22.
//

import UIKit

class HomeView: UIView {
    // MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundImage)
        addSubview(title)
        addSubview(sortingContainer)
        addSubview(dividerView)
        addSubview(tableView)
        addSubview(refreshButton)
        addSubview(poweredByContainer)
        addConstraints([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.heightAnchor.constraint(equalToConstant: 160),
            
            title.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -38),
            title.widthAnchor.constraint(equalToConstant: 260),
            title.heightAnchor.constraint(equalToConstant: 45),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            sortingContainer.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            sortingContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -1),
            sortingContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 1),
            sortingContainer.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -5),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: refreshButton.topAnchor, constant: -10),
            
            refreshButton.bottomAnchor.constraint(equalTo: poweredByContainer.topAnchor, constant: -15),
            refreshButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            refreshButton.heightAnchor.constraint(equalToConstant: 45),
            
            poweredByContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            poweredByContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            poweredByContainer.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not using Storyboards")
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
        return imageView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.systemBackground
        label.text = "Trending Coins"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    lazy var sortingContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.75
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Sort by:"
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .black
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(imageView)
        view.addConstraints([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -10),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            textField.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -12),
            textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            textField.widthAnchor.constraint(equalToConstant: 200),
            textField.heightAnchor.constraint(equalToConstant: 35),
            
            imageView.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -10),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.text = "Trending Rank"
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        return textField
    }()
    
    lazy var dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator
        return view
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
