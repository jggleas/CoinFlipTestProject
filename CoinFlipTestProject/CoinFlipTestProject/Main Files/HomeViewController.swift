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
    private var sortByList: [TrendingSortType] = [.score, .rank, .nameUp, .nameDown, .priceLow, .priceHigh]
    private var pickerView = UIPickerView()
    
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
        
        pickerView.delegate = self
        pickerView.dataSource = self
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneWithPicker))
        let items = [flexSpace, doneButton]
        toolbar.items = items
        toolbar.sizeToFit()
        
        homeView.textField.inputView = pickerView
        homeView.textField.inputAccessoryView = toolbar
        homeView.textField.delegate = self
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.reuseId)
        homeView.refreshButton.addTarget(self, action: #selector(refresh(_:)), for: .touchUpInside)
    }
    
    @objc func refresh(_ sender: UIButton) {
        homeView.startLoading()
        CoinApi.shared.refresh()
    }
    
    @objc func doneWithPicker() {
        let selected = sortByList[pickerView.selectedRow(inComponent: 0)]
        homeView.textField.text = selected.rawValue
        switch selected {
        case .score:
            sortedTrending = sortedTrending.sorted(by: { $1.score > $0.score })
        case .rank:
            sortedTrending = sortedTrending.sorted(by: { $1.market_cap_rank > $0.market_cap_rank })
        case .nameUp:
            sortedTrending = sortedTrending.sorted(by: { $1.name > $0.name })
        case .nameDown:
            sortedTrending = sortedTrending.sorted(by: { $1.name < $0.name })
        case .priceLow:
            sortedTrending = sortedTrending.sorted(by: { $1.price_btc > $0.price_btc })
        case .priceHigh:
            sortedTrending = sortedTrending.sorted(by: { $1.price_btc < $0.price_btc })
        }
        homeView.textField.resignFirstResponder()
        homeView.tableView.reloadData()
    }
}

extension HomeViewController: CoinApiObservers {
    func loaded(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.sortedTrending = CoinApi.shared.trending
            self?.doneWithPicker()
            self?.homeView.stopLoading()
            self?.homeView.tableView.reloadData()
        }
    }
}

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortByList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortByList[row].rawValue
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedTrending.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.reuseId, for: indexPath) as? CoinTableViewCell else {
            fatalError("Failed to cast as CoinCell")
        }
        cell.configure(coin: sortedTrending[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CoinViewController(for: sortedTrending[indexPath.row])
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
