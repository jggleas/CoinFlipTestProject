//
//  UIImageView+.swift
//  CoinFlipTestProject
//
//  Created by Jacob Gleason on 9/20/22.
//

import UIKit

extension UIImageView {
    func loadImage(urlString: String) {
        let indicator = UIActivityIndicatorView()
        addSubview(indicator)
        indicator.backgroundColor = .clear
        indicator.frame = bounds
        indicator.center.x = frame.width / 2
        indicator.center.y = frame.height / 2
        indicator.color = .black
        indicator.startAnimating()
        
        if let data = UserDefaults.standard.data(forKey: urlString) {
            if let image = UIImage(data: data) {
                self.image = image
            }
            indicator.removeFromSuperview()
        } else if let url = URL(string: urlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async { [weak self] in
                            self?.image = image
                            UserDefaults.standard.set(data, forKey: urlString)
                            indicator.removeFromSuperview()
                            
                        }
                    }
                }
            }
        } else {
            indicator.removeFromSuperview()
        }
    }
}
