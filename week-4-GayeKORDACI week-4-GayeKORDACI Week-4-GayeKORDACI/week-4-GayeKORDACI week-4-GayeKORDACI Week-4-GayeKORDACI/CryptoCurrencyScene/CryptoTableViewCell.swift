//
//  CryptoTableViewCell.swift
//  week-4-GayeKORDACI week-4-GayeKORDACI Week-4-GayeKORDACI
//
//  Created by Gaye Kordacı Deprem on 13.06.2022.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceUsdLabel: UILabel!
    @IBOutlet weak var changePercent24HrLabel: UILabel!
    @IBOutlet weak var cryptoImage: UIImageView!


    func setData(_ data: CryptoDesignModel) {
        nameLabel?.text = data.cryptoCurrency.name
        symbolLabel?.text = data.cryptoCurrency.symbol
        symbolLabel.textColor = .lightGray
        let price = Float(data.cryptoCurrency.priceUsd ?? "") ?? 0
        priceUsdLabel?.text = String(format: "%.02f", price)
        
        let change = Float(data.cryptoCurrency.changePercent24Hr ?? "") ?? 0
        if change > 0 {
            changePercent24HrLabel.textColor = .green
            changePercent24HrLabel?.text = String(format: "↑ %.02f%%", change)

        }else {
            changePercent24HrLabel.textColor = .red
            changePercent24HrLabel?.text = String(format: "↓ %.02f%%", change)
        }
        cryptoImage.image = UIImage(named: data.imageString ?? "") ?? UIImage(named: "blackbtc")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
