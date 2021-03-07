//
//  customPickerView.swift
//  Timer
//
//  Created by Ingrid on 18/11/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit

class CustomPickerView: UIView {
    
    let numbers = ["0","1","2","3","4","5","6","7","8","9"]
    var thousandthLengthValue = 0
    var hundredthLengthValue = 0
    var tenthLengthValue = 0
    var singleLengthValue = 0
    var userSelectedNumber = 0
    var numberOfComponents = 3
    
    let picker: MyPickerView = {
        let picker = MyPickerView()
        picker.tag = 1
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = .clear
        return picker
    }()
    
    let pickerLengthBackgroundDetail: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.accentColor
        view.layer.cornerRadius = Constants.smallCornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        return view
    }()
        
    let detail1: UIView = {
        let detail1 = UIView()
        detail1.translatesAutoresizingMaskIntoConstraints = false
        detail1.backgroundColor = Constants.accentColorDark
        detail1.alpha = 1
        detail1.layer.cornerRadius = Constants.smallCornerRadius
        return detail1
    }()
        
    let detail2: UIView = {
        let detail2 = UIView()
        detail2.translatesAutoresizingMaskIntoConstraints = false
        detail2.backgroundColor = Constants.accentColorDark
        detail2.alpha = 1
        detail2.layer.cornerRadius = Constants.smallCornerRadius
        return detail2
    }()

    let detail3: UIView = {
        let detail3 = UIView()
        detail3.translatesAutoresizingMaskIntoConstraints = false
        detail3.backgroundColor = Constants.accentColorDark
        detail3.alpha = 1
        detail3.layer.cornerRadius = Constants.smallCornerRadius
        return detail3
    }()
    
    let unitLabel: UILabel = {
        let unitLabel = UILabel()
        unitLabel.translatesAutoresizingMaskIntoConstraints = false
        unitLabel.backgroundColor = .clear
        unitLabel.text = Constants.meters
        unitLabel.font = Constants.mainFontXXLargeSB
        unitLabel.textColor = .black
        return unitLabel
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.text = Constants.lengthOfLap
        label.font = Constants.mainFont
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(pickerLengthBackgroundDetail)
        pickerLengthBackgroundDetail.addSubview(detail1)
        pickerLengthBackgroundDetail.addSubview(detail2)
        pickerLengthBackgroundDetail.addSubview(detail3)
        pickerLengthBackgroundDetail.addSubview(unitLabel)
        pickerLengthBackgroundDetail.addSubview(label)
        
        picker.dataSource = self
        picker.delegate = self
        
        setConstraints()
    }
    
    init(subTitle: String, unit: String, number: Int) {
        super.init(frame: .zero)
        self.addSubview(pickerLengthBackgroundDetail)
        pickerLengthBackgroundDetail.addSubview(detail1)
        pickerLengthBackgroundDetail.addSubview(detail2)
        pickerLengthBackgroundDetail.addSubview(detail3)
        pickerLengthBackgroundDetail.addSubview(unitLabel)
        pickerLengthBackgroundDetail.addSubview(label)
        pickerLengthBackgroundDetail.addSubview(picker)
        unitLabel.text = unit
        label.text = subTitle
        
        picker.dataSource = self
        picker.delegate = self
        
        numberOfComponents = number

        setNumberOfPickerElements(number: number)
        
        if number == 2 {
            setConstraintsFor2Components()
        }
        else {
            setConstraints()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNumberOfPickerElements(number: Int) {
        if number == 2 {
            detail3.isHidden = true
        }
    }
    
    func setConstraints() {
        pickerLengthBackgroundDetail.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        pickerLengthBackgroundDetail.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        pickerLengthBackgroundDetail.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        pickerLengthBackgroundDetail.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        picker.topAnchor.constraint(equalTo: pickerLengthBackgroundDetail.topAnchor, constant: Constants.sideMargin).isActive = true
        picker.leadingAnchor.constraint(equalTo: pickerLengthBackgroundDetail.leadingAnchor,constant: Constants.sideMargin).isActive = true
        picker.bottomAnchor.constraint(equalTo: pickerLengthBackgroundDetail.bottomAnchor, constant: -Constants.sideMargin * 1.5).isActive = true
        picker.widthAnchor.constraint(equalToConstant: Constants.widthOfLengthPicker).isActive = true
        
        detail1.leadingAnchor.constraint(equalTo: pickerLengthBackgroundDetail.leadingAnchor, constant: Constants.sideMargin).isActive = true
        detail1.widthAnchor.constraint(equalToConstant: Constants.widthOfPickerLabel).isActive = true
        detail1.topAnchor.constraint(equalTo: pickerLengthBackgroundDetail.topAnchor, constant: Constants.sideMargin).isActive = true
        detail1.bottomAnchor.constraint(equalTo: pickerLengthBackgroundDetail.bottomAnchor, constant: -Constants.sideMargin * 1.5).isActive = true
        
        detail2.leadingAnchor.constraint(equalTo: detail1.trailingAnchor, constant: 5).isActive = true
        detail2.widthAnchor.constraint(equalToConstant: Constants.widthOfPickerLabel).isActive = true
        detail2.topAnchor.constraint(equalTo: pickerLengthBackgroundDetail.topAnchor, constant: Constants.sideMargin).isActive = true
        detail2.bottomAnchor.constraint(equalTo: pickerLengthBackgroundDetail.bottomAnchor, constant: -Constants.sideMargin * 1.5).isActive = true
        
        detail3.leadingAnchor.constraint(equalTo: detail2.trailingAnchor, constant: 5).isActive = true
        detail3.widthAnchor.constraint(equalToConstant: Constants.widthOfPickerLabel).isActive = true
        detail3.topAnchor.constraint(equalTo: pickerLengthBackgroundDetail.topAnchor, constant: Constants.sideMargin).isActive = true
        detail3.bottomAnchor.constraint(equalTo: pickerLengthBackgroundDetail.bottomAnchor, constant: -Constants.sideMargin * 1.5).isActive = true
        
        unitLabel.topAnchor.constraint(equalTo: pickerLengthBackgroundDetail.topAnchor, constant: Constants.sideMargin).isActive = true
        unitLabel.bottomAnchor.constraint(equalTo: pickerLengthBackgroundDetail.bottomAnchor, constant: -Constants.sideMargin * 1.5).isActive = true
        unitLabel.leadingAnchor.constraint(equalTo: detail3.trailingAnchor, constant: Constants.sideMargin * 0.5).isActive = true
        unitLabel.widthAnchor.constraint(equalToConstant: Constants.widthOfPickerLabel).isActive = true
        
        label.topAnchor.constraint(equalTo: detail1.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: pickerLengthBackgroundDetail.leadingAnchor, constant: Constants.sideMargin).isActive = true
        label.trailingAnchor.constraint(equalTo: pickerLengthBackgroundDetail.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: pickerLengthBackgroundDetail.bottomAnchor, constant: -2.5).isActive = true
    }
    
    func setConstraintsFor2Components() {
        pickerLengthBackgroundDetail.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        pickerLengthBackgroundDetail.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        pickerLengthBackgroundDetail.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        pickerLengthBackgroundDetail.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        picker.topAnchor.constraint(equalTo: pickerLengthBackgroundDetail.topAnchor, constant: Constants.sideMargin).isActive = true
        picker.leadingAnchor.constraint(equalTo: pickerLengthBackgroundDetail.leadingAnchor,constant: Constants.sideMargin).isActive = true
        picker.bottomAnchor.constraint(equalTo: pickerLengthBackgroundDetail.bottomAnchor, constant: -Constants.sideMargin * 1.5).isActive = true
        picker.widthAnchor.constraint(equalToConstant: Constants.widthOfLengthPicker * 2/3).isActive = true
        
        detail1.leadingAnchor.constraint(equalTo: pickerLengthBackgroundDetail.leadingAnchor, constant: Constants.sideMargin).isActive = true
        detail1.widthAnchor.constraint(equalToConstant: Constants.widthOfPickerLabel).isActive = true
        detail1.topAnchor.constraint(equalTo: pickerLengthBackgroundDetail.topAnchor, constant: Constants.sideMargin).isActive = true
        detail1.bottomAnchor.constraint(equalTo: pickerLengthBackgroundDetail.bottomAnchor, constant: -Constants.sideMargin * 1.5).isActive = true
        
        detail2.leadingAnchor.constraint(equalTo: detail1.trailingAnchor, constant: 5).isActive = true
        detail2.widthAnchor.constraint(equalToConstant: Constants.widthOfPickerLabel).isActive = true
        detail2.topAnchor.constraint(equalTo: pickerLengthBackgroundDetail.topAnchor, constant: Constants.sideMargin).isActive = true
        detail2.bottomAnchor.constraint(equalTo: pickerLengthBackgroundDetail.bottomAnchor, constant: -Constants.sideMargin * 1.5).isActive = true
        
        detail3.leadingAnchor.constraint(equalTo: detail2.trailingAnchor, constant: 5).isActive = true
        detail3.widthAnchor.constraint(equalToConstant: Constants.widthOfPickerLabel).isActive = true
        detail3.topAnchor.constraint(equalTo: pickerLengthBackgroundDetail.topAnchor, constant: Constants.sideMargin).isActive = true
        detail3.bottomAnchor.constraint(equalTo: pickerLengthBackgroundDetail.bottomAnchor, constant: -Constants.sideMargin * 1.5).isActive = true
        
        unitLabel.topAnchor.constraint(equalTo: pickerLengthBackgroundDetail.topAnchor, constant: Constants.sideMargin).isActive = true
        unitLabel.bottomAnchor.constraint(equalTo: pickerLengthBackgroundDetail.bottomAnchor, constant: -Constants.sideMargin * 1.5).isActive = true
        unitLabel.leadingAnchor.constraint(equalTo: detail2.trailingAnchor, constant: Constants.sideMargin * 0.5).isActive = true
        unitLabel.widthAnchor.constraint(equalToConstant: Constants.widthOfPickerLabel).isActive = true
        
        label.topAnchor.constraint(equalTo: detail1.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: pickerLengthBackgroundDetail.leadingAnchor, constant: Constants.sideMargin).isActive = true
        label.trailingAnchor.constraint(equalTo: pickerLengthBackgroundDetail.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: pickerLengthBackgroundDetail.bottomAnchor, constant: -2.5).isActive = true
    }
    
    func setTexts(subTitle: String, unit: String) {
        unitLabel.text = unit
        label.text = subTitle
    }
}

extension CustomPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numbers[row]
    }
}

extension CustomPickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if numberOfComponents == 2 {
            return 2
        }
        else {
            return 3
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numbers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if numberOfComponents == 2 {
            tenthLengthValue = Int(numbers[pickerView.selectedRow(inComponent: 0)]) ?? 0
            singleLengthValue = Int(numbers[pickerView.selectedRow(inComponent: 1)]) ?? 0
            userSelectedNumber = tenthLengthValue * 10 + singleLengthValue
        }
        else {
            hundredthLengthValue = Int(numbers[pickerView.selectedRow(inComponent: 0)]) ?? 0
            tenthLengthValue = Int(numbers[pickerView.selectedRow(inComponent: 1)]) ?? 0
            singleLengthValue = Int(numbers[pickerView.selectedRow(inComponent: 2)]) ?? 0
            userSelectedNumber = hundredthLengthValue * 100 + tenthLengthValue * 10 + singleLengthValue
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: numbers[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return Constants.widthOfPickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.font = Constants.mainFontXXLargeSB
        label.backgroundColor = .clear
        label.textColor = .white
        label.text =  numbers[row]
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerView.frame.height * 1
    }
}

