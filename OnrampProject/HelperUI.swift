//
//  HelperUI.swift
//  OnrampProject
//
//  Created by Julia Rodriguez on 3/4/20.
//

import UIKit

class HelperUI {
    
    static func presentUIHelperAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(okayAction)
        //self.present(alertController, animated: true)
    }
}
