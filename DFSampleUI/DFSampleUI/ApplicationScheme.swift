//
//  ApplicationScheme.swift
//  DFSampleUI
//
//  Created by Santhosh Vaddi on 1/20/19.
//  Copyright © 2019 Santhosh Vaddi. All rights reserved.
//

import UIKit
import MaterialComponents

class ApplicationScheme: NSObject {
    
    private static var singleton = ApplicationScheme()
    
    static var shared: ApplicationScheme {
        return singleton
    }
    
    override init() {
        self.buttonScheme.colorScheme = self.colorScheme
        self.buttonScheme.typographyScheme = self.typographyScheme
        super.init()
    }
    
    public let buttonScheme = MDCButtonScheme()
    
    public let colorScheme: MDCColorScheming = {
        let scheme = MDCSemanticColorScheme(defaults: .material201804)
        //TODO: Customize our app Colors after this line
        scheme.primaryColor = #colorLiteral(red: 0.9882352941, green: 0.7215686275, blue: 0.6705882353, alpha: 1)
        //UIColor(red: 252.0/255.0, green: 184.0/255.0, blue: 171.0/255.0, alpha: 1.0)
        scheme.primaryColorVariant = #colorLiteral(red: 0.2666666667, green: 0.1725490196, blue: 0.1803921569, alpha: 1)
        //UIColor(red: 68.0/255.0, green: 44.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        scheme.onPrimaryColor = #colorLiteral(red: 0.2666666667, green: 0.1725490196, blue: 0.1803921569, alpha: 1)
        //UIColor(red: 68.0/255.0, green: 44.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        scheme.secondaryColor = 
            UIColor(red: 254.0/255.0, green: 234.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        scheme.onSecondaryColor =
            UIColor(red: 68.0/255.0, green: 44.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        scheme.surfaceColor =
            UIColor(red: 255.0/255.0, green: 251.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        scheme.onSurfaceColor =
            UIColor(red: 68.0/255.0, green: 44.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        scheme.backgroundColor =
            UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        scheme.onBackgroundColor =
            UIColor(red: 68.0/255.0, green: 44.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        scheme.errorColor =
            UIColor(red: 197.0/255.0, green: 3.0/255.0, blue: 43.0/255.0, alpha: 1.0)
        return scheme
    }()
    
    public let typographyScheme: MDCTypographyScheming = {
        let scheme = MDCTypographyScheme()
        //TODO: Add our custom fonts after this line
        let fontName = "Rubik"
        scheme.headline5 = UIFont(name: fontName, size: 24)!
        scheme.headline6 = UIFont(name: fontName, size: 20)!
        scheme.subtitle1 = UIFont(name: fontName, size: 16)!
        scheme.button = UIFont(name: fontName, size: 14)!
        return scheme
    }()
}
