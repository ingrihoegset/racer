//
//  Constants.swift
//  Racer
//
//  Created by Ingrid on 11/02/2021.
//

import Foundation
import UIKit

struct Constants {
 
    //Colors
    static let mainColor = UIColor(named: "MainColor")
    static let accentColor = UIColor(named: "AccentColor")
    static let accentColorDark = UIColor(named: "AccentColorDark")
    static let whiteColor = UIColor(named: "WhiteColor")
    static let contrastColor = UIColor(named: "ContrastColor")
    
    
    //Text Colors
    static let textColorMain = UIColor.black
    
    //Design dimensions
    static let smallCornerRadius: CGFloat = 4
    static let borderWidth: CGFloat = 1
    static let sideSpacing: CGFloat = 15
    static let verticalSpacing: CGFloat = 20
    static let fieldHeight: CGFloat = 52
    static let fieldHeightLarge: CGFloat = fieldHeight * 3
    
    // Set race VC texts
    static let noOfLaps = "Number of laps"
    static let lengthOfLap = "Lap length"
    static let delayTime = "Seconds delay before start"
    static let reactionPeriod = "Reaction period"
    
    //European Units
    static let meters = "m"
    static let seconds = "s"
    
    // Dimension
    static let widthOfDisplay = UIScreen.main.bounds.size.width
    static let heightOfDisplay = UIScreen.main.bounds.size.height
    static let sideMargin = widthOfDisplay * 0.05
    
    // Picker dimensions
    static let widthOfPickerLabel = Constants.widthOfDisplay * 0.2
    static let widthOfLengthPicker = widthOfPickerLabel * 3
    static let widthOfDelayPicker = widthOfPickerLabel * 2
    
    // Fonts
    static let mainFontLarge = UIFont(name: "BarlowSemiCondensed-Light", size: 22)
    static let mainFont = UIFont(name: "BarlowSemiCondensed-Light", size: 18)
    static let mainFontMedium = UIFont(name: "BarlowSemiCondensed-Light", size: 14)
    static let mainFontSmall = UIFont(name: "BarlowSemiCondensed-Light", size: 12)
    static let mainFontLargeSB = UIFont(name: "BarlowSemiCondensed-SemiBold", size: 22)
    static let mainFontXLargeSB = UIFont(name: "BarlowSemiCondensed-SemiBold", size: 35)
    static let mainFontXXLargeSB = UIFont(name: "BarlowSemiCondensed-SemiBold", size: 55)
    static let mainFontSB = UIFont(name: "BarlowSemiCondensed-SemiBold", size: 18)
    static let mainFontMediumSB = UIFont(name: "BarlowSemiCondensed-SemiBold", size: 14)
    static let mainFontSmallSB = UIFont(name: "BarlowSemiCondensed-SemiBold", size: 10)
    static let countDownFont = UIFont(name: "BarlowSemiCondensed-SemiBold", size: 160)
}
