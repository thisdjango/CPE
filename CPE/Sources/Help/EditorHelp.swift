//
//  EditorHelp.swift
//  CPE
//
//  Created by Diana Tsarkova on 06.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit

class EditorHelp {
    
    static func textToImage(with textObject: TextObject, at point: CGPoint, in image: UIImage) -> UIImage {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textObject.font,
            NSAttributedString.Key.foregroundColor: textObject.color,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        let rect = CGRect(origin: point, size: image.size)
        textObject.string.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage ?? UIImage()
    }
    
}
