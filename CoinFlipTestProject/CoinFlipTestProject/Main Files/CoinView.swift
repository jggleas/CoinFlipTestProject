import UIKit

class CoinView: UIView {
    // MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(backButton)
        addSubview(coinImageView)
        addSubview(nameLabel)
        addSubview(symbolLabel)
        addSubview(dividerView)
        addSubview(priceView)
        addSubview(priceLabel)
        addSubview(trendingRankLabel)
        addSubview(marketCapRankLabel)
        addConstraints([
            backButton.topAnchor.constraint(equalTo: coinImageView.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            
            coinImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            coinImageView.widthAnchor.constraint(equalToConstant: 150),
            coinImageView.heightAnchor.constraint(equalToConstant: 150),
            coinImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: coinImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            symbolLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            dividerView.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 10),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 0.75),
            
            priceView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 10),
            priceView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            priceLabel.topAnchor.constraint(equalTo: priceView.topAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: priceView.leadingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: priceView.trailingAnchor, constant: -10),
            priceLabel.bottomAnchor.constraint(equalTo: priceView.bottomAnchor, constant: -10),
            
            trendingRankLabel.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: 10),
            trendingRankLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            marketCapRankLabel.topAnchor.constraint(equalTo: trendingRankLabel.bottomAnchor, constant: 10),
            marketCapRankLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
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
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return button
    }()
    
    lazy var coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.systemBackground
        label.text = "Trending Coins"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        label.textAlignment = .left
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    lazy var dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator
        return view
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
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var marketCapRankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var trendingRankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
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
