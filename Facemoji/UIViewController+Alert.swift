//
//  UIViewController+Alert.swift
//  Facemoji
//
//  Created by Fernando Ortiz on 9/17/17.
//  Copyright © 2017 Fernando Ortiz. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(_ text: String) {
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Accept", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
