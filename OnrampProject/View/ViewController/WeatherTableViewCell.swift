//
//  WeatherTableViewCell.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/5/20.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var timeDateLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
