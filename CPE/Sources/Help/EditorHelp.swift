//
//  EditorHelp.swift
//  CPE
//
//  Created by Diana Tsarkova on 06.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit

class EditorHelp {
    
    static func textToImage(with text: String, at point: CGPoint, in image: UIImage, style textStyle: TextStyle) -> UIImage {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: UIFont(name: textStyle.font,
                                                size: CGFloat(textStyle.size)) ?? UIFont.systemFont(ofSize: 30),
            NSAttributedString.Key.foregroundColor: textStyle.color,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage ?? UIImage()
    }
    
}
