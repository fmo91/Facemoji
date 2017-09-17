//
//  UIView+Snapshot.swift
//  Facemoji
//
//  Created by Fernando Ortiz on 9/17/17.
//  Copyright © 2017 Fernando Ortiz. All rights reserved.
//

import UIKit

extension UIView {
    var snapshot: UIImage? {
        UIGraphicsBeginImageContext(self.frame.size)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        self.layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
