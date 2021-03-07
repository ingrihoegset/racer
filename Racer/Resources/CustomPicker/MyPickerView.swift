//
//  MyPickerView.swift
//  Timer
//
//  Created by Ingrid on 13/11/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//
import Foundation
import UIKit

class MyPickerView: UIPickerView {

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.borderWidth = 0 // Main view rounded border

        // Component borders
        self.subviews.forEach {
            $0.layer.borderWidth = 0
            $0.backgroundColor = .clear
            $0.isHidden = $0.frame.height <= 1.0
        }
    }

}
