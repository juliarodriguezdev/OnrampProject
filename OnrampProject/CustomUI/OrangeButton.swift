//
//  OrangeButton.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/5/20.
//

import UIKit

class OrangeButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
        
    }
    
    func updateFont(to fontName: String) {
        self.titleLabel?.font = UIFont(name: fontName, size: 20)
    }
    
    func setUpUI() {
        self.backgroundColor = UIColor.customLightOrange
        self.setTitleColor(.black, for: .normal)
        updateFont(to: FontNames.avenirBook)
        self.addCornerRadius(14)
        
    }
}
