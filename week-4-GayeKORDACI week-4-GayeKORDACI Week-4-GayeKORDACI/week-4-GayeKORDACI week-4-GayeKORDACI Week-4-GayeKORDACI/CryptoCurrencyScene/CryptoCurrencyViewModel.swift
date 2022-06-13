//
//  CryptoCurrencyViewModel.swift
//  week-4-GayeKORDACI week-4-GayeKORDACI Week-4-GayeKORDACI
//
//  Created by Gaye Kordacı Deprem on 13.06.2022.
//

import Foundation

class CryptoCurrencyViewModel {
    
    var isRefreshing: ((Bool) -> Void)?
    var didUpdateCryptos: (([CryptoDesignModel]) -> Void)?
    var didSelecteCryptos: ((String) -> Void)?
    
    private(set) var cryptos: [CryptoCurrency] = [CryptoCurrency]() {
        didSet {
            didUpdateCryptos?(cryptos.map { CryptoDesignModel(crypto: $0) })
        }
    }
    
    // Dependencies
    private let networkingService: NetworkingService
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    // Inputs
    func ready() {
        isRefreshing?(true)
        
        networkingService.fetchCoins { cryptos in
            self.isRefreshing?(false)
            self.cryptos = cryptos
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if cryptos.isEmpty { return }
        didSelecteCryptos?(cryptos[indexPath.item].explorer ?? "")
    }
}


struct CryptoDesignModel {
    let cryptoCurrency: CryptoCurrency
    let imageString: String?
    init(crypto: CryptoCurrency) {
        self.cryptoCurrency = crypto
        self.imageString = cryptoCurrency.symbol?.lowercased()
    }
}
