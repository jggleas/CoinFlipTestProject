//
//  HomeViewController.swift
//  CoinFlipTestProject
//
//  Created by Jacob Gleason on 9/17/22.
//

import UIKit

class HomeViewController: UIViewController {
    private var homeView = HomeView()
    private var sortedTrending: [Coin] = CoinApi.shared.trending
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CoinApi.shared.loadingTrending { homeView.startLoading() }
        NotificationCenter.default.addObserver(self, selector: #selector(loaded(_:)), name: Notification.Name("Loaded"), object: nil)
        CoinApi.shared.setup()
        view.backgroundColor = .systemBackground
        view.addSubview(homeView)
        
        homeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        homeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        homeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        homeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.reuseId)
        homeView.refreshButton.addTarget(self, action: #selector(refresh(_:)), for: .touchUpInside)
    }
    
    @objc func refresh(_ sender: UIButton) {
        homeView.startLoading()
        CoinApi.shared.refresh()
    }
}

extension HomeViewController: CoinApiObservers {
    func loaded(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.homeView.stopLoading()
            self?.homeView.tableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoinApi.shared.trending.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.reuseId, for: indexPath) as? CoinTableViewCell else {
            fatalError("Failed to cast as CoinCell")
        }
        cell.configure(coin: CoinApi.shared.trending[indexPath.row])
        return cell
    }
}
