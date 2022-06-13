//
//  CryptoCurrencyViewController.swift
//  week-4-GayeKORDACI week-4-GayeKORDACI Week-4-GayeKORDACI
//
//  Created by Gaye Kordacı Deprem on 13.06.2022.
//

import UIKit

class CryptoCurrencyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: CryptoCurrencyViewModel?
   
    private var data: [CryptoDesignModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.viewModel = CryptoCurrencyViewModel(networkingService: NetworkingApi())
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let networkingService = NetworkingApi()
        networkingService.fetchCoins() { datas in
           
            print(datas)
        }
            
        setupViewModel()
        
    }
    
    private func setupViewModel() {
        viewModel?.isRefreshing = { loading in
            UIApplication.shared.isNetworkActivityIndicatorVisible = loading
        }
     
        viewModel?.didUpdateCryptos = { [weak self] cryptos in
            guard let strongSelf = self else { return }
            strongSelf.data = cryptos
            strongSelf.tableView.reloadData()
        }
        
        viewModel?.didSelecteCryptos = { [weak self] id in
            guard let strongSelf = self else { return }
            let alertController = UIAlertController(title: "\(id)", message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            strongSelf.present(alertController, animated: true, completion: nil)
        }
        
        viewModel?.ready()
    }

}

extension CryptoCurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = data else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoTableViewCell", for: indexPath) as! CryptoTableViewCell
        cell.setData(data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
