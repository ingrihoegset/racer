//
//  raceDetailsSetUpViewController.swift
//  Racer
//
//  Created by Ingrid on 24/02/2021.
//

import UIKit

class SpeedRaceDetailsViewController: UIViewController {
    
    var partnerId = ""
    var raceId = ""
    
    let newRaceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.accentColorDark
        button.setTitle("New Race", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), for: .selected)
        button.addTarget(self, action: #selector(didTapNewRace), for: .touchUpInside)
        button.layer.cornerRadius = Constants.smallCornerRadius
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowRadius = 2.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        return button
    }()
    
    let lengthPicker: CustomPickerView = {
        let picker = CustomPickerView(subTitle: Constants.lengthOfLap, unit: "m", number: 3)
        picker.translatesAutoresizingMaskIntoConstraints = false
        return  picker
    }()
    
    let delayPicker: CustomPickerView = {
        let picker = CustomPickerView(subTitle: Constants.delayTime, unit: "s", number: 2)
        picker.translatesAutoresizingMaskIntoConstraints = false
        return  picker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Set Race Details"
        view.backgroundColor = Constants.whiteColor

        view.addSubview(delayPicker)
        view.addSubview(lengthPicker)
        view.addSubview(newRaceButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        delayPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideMargin).isActive = true
        delayPicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.sideMargin).isActive = true
        delayPicker.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.235).isActive = true
        delayPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideMargin).isActive = true
        
        lengthPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideMargin).isActive = true
        lengthPicker.topAnchor.constraint(equalTo: delayPicker.bottomAnchor, constant: Constants.sideMargin).isActive = true
        lengthPicker.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.235).isActive = true
        lengthPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideMargin).isActive = true
        
        newRaceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newRaceButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.sideMargin).isActive = true
        newRaceButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.235/2).isActive = true
        newRaceButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -Constants.sideMargin * 2).isActive = true
        
        
    }
    
    @objc private func didTapNewRace() {
        
        let destinationController = StartGateViewController()

        destinationController.userSelectedLength = lengthPicker.userSelectedNumber
        if (lengthPicker.userSelectedNumber == 0) {
            destinationController.userSelectedLength = Int(60)
        }
        
        destinationController.userSelectedDelay = delayPicker.userSelectedNumber
        if (delayPicker.userSelectedNumber == 0) {
            destinationController.userSelectedDelay = Int(10)
        }
        
        destinationController.partnerId = partnerId
        destinationController.raceId = raceId

        navigationController?.pushViewController(destinationController, animated: false)
    }
    



}
