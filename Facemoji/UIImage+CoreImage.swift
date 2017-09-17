//
//  UIImage+CoreImage.swift
//  Facemoji
//
//  Created by Fernando Ortiz on 9/17/17.
//  Copyright © 2017 Fernando Ortiz. All rights reserved.
//

import UIKit
import CoreImage

extension UIImage {
    func getFacesBounds(for imageView: UIImageView, extendedBy sizeExtensionFactor: CGFloat = 0.0) -> [CGRect] {
        guard let targetImage = CIImage(image: self) else { return [] }
        let detectionAccuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: detectionAccuracy)
        let foundFaces = faceDetector?.features(in: targetImage)
        
        // For converting the Core Image Coordinates to UIView Coordinates
        let detectedImageSize = targetImage.extent.size
        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -detectedImageSize.height)
        
        var detectedBounds = [CGRect]()
        
        for face in foundFaces as! [CIFaceFeature] {
            var newBounds = face.bounds.applying(transform)
            
            // Calculate the actual position of indicator
            let viewSize = imageView.bounds.size
            let scale = min(viewSize.width / detectedImageSize.width,
                            viewSize.height / detectedImageSize.height)
            let offsetX = (viewSize.width - detectedImageSize.width * scale) / 2
            let offsetY = (viewSize.height - detectedImageSize.height * scale) / 2
            
            newBounds = newBounds.applying(CGAffineTransform(scaleX: scale, y: scale))
            let sizeExtension: CGFloat = newBounds.size.width * sizeExtensionFactor
            
            newBounds.origin.x += offsetX - (sizeExtension / 2.0)
            newBounds.origin.y += offsetY - (sizeExtension / 2.0)
            newBounds.size.width += sizeExtension
            newBounds.size.height += sizeExtension
            
            detectedBounds.append(newBounds)
        }
        
        return detectedBounds
    }
}
