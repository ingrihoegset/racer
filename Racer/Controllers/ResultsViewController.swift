//
//  ResultsViewController.swift
//  Racer
//
//  Created by Ingrid on 07/03/2021.
//

import UIKit

class ResultsViewController: UIViewController {

    var hidden = true
    
    let resultContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.accentColorDark
        view.layer.cornerRadius = Constants.smallCornerRadius
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        return view
    }()
    
    let raceTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Constants.whiteColor
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.text = "Race time "
        label.font = Constants.mainFontLargeSB
        return label
    }()
    
    let raceTimeHundreths: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Constants.whiteColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = Constants.accentColorDark
        label.isUserInteractionEnabled = false
        label.font = Constants.mainFontXLargeSB
        return label
    }()
    
    let raceTimeSeconds: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Constants.whiteColor
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = Constants.accentColorDark
        label.isUserInteractionEnabled = false
        label.font = Constants.mainFontXLargeSB
        return label
    }()
    
    let raceTimeMinutes: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Constants.whiteColor
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = Constants.accentColorDark
        label.isUserInteractionEnabled = false
        label.font = Constants.mainFontXLargeSB
        return label
    }()
    
    let raceTimeHundrethsTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Constants.whiteColor
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = Constants.accentColorDark
        label.isUserInteractionEnabled = false
        label.font = Constants.mainFont
        label.text = "CENTISECONDS"
        return label
    }()
    
    let raceTimeSecondsTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Constants.whiteColor
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = Constants.accentColorDark
        label.isUserInteractionEnabled = false
        label.font = Constants.mainFont
        label.text = "SECONDS"
        return label
    }()
    
    let raceTimeMinutesTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Constants.whiteColor
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = Constants.accentColorDark
        label.isUserInteractionEnabled = false
        label.font = Constants.mainFont
        label.text = "MINUTES"
        return label
    }()
    
    let raceSpeedTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Constants.whiteColor
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = Constants.accentColorDark
        label.isUserInteractionEnabled = false
        label.font = Constants.mainFont
        label.text = "AVERAGE SPEED"
        return label
    }()
    
    let racelengthTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Constants.whiteColor
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = Constants.accentColorDark
        label.isUserInteractionEnabled = false
        label.font = Constants.mainFont
        label.text = "TOTAL DISTANCE"
        return label
    }()
    
    let raceSpeedResult: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Constants.whiteColor
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = Constants.accentColorDark
        label.isUserInteractionEnabled = false
        label.font = Constants.mainFontXLargeSB
        return label
    }()
    
    let racelengthResult: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Constants.whiteColor
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = Constants.accentColorDark
        label.isUserInteractionEnabled = false
        label.font = Constants.mainFontXLargeSB
        return label
    }()
    
    let saveRaceButton: UIButton = {
         let button = UIButton()
         button.translatesAutoresizingMaskIntoConstraints = false
         button.backgroundColor = Constants.accentColorDark
         button.setTitle("Save race", for: .normal)
         button.setTitleColor(.white, for: .normal)
         button.setTitleColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), for: .selected)
         button.addTarget(self, action: #selector(saveRace), for: .touchUpInside)
         return button
    }()
    
    /*
    let seeDetailsButton: UIButton = {
         let button = UIButton()
         button.translatesAutoresizingMaskIntoConstraints = false
         button.backgroundColor = Constants.contrastColor
         button.setTitle("See Run Details", for: .normal)
         button.setTitleColor(.white, for: .normal)
         button.titleLabel?.font = Constants.mainFont
         button.addTarget(self, action: #selector(goToResults), for: .touchUpInside)
         button.layer.cornerRadius = Constants.smallCornerRadius
         button.clipsToBounds = true
         button.layer.shadowColor = UIColor.black.cgColor
         button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
         button.layer.shadowRadius = 2.0
         button.layer.shadowOpacity = 0.5
         button.layer.masksToBounds = false

         return button
    }()*/
    
    let detailComponent1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.accentColorDark
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = Constants.smallCornerRadius
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        return view
    }()
    
    let detailComponent2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.accentColorDark
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = Constants.smallCornerRadius
        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Results"
        view.backgroundColor = Constants.mainColor
        
        setResults()
        
        view.addSubview(resultContainer)
        resultContainer.addSubview(raceTimeLabel)
        resultContainer.addSubview(raceTimeMinutes)
        resultContainer.addSubview(raceTimeSeconds)
        resultContainer.addSubview(raceTimeHundreths)
        resultContainer.addSubview(raceTimeMinutesTitle)
        resultContainer.addSubview(raceTimeSecondsTitle)
        resultContainer.addSubview(raceTimeHundrethsTitle)

        view.addSubview(detailComponent1)
        detailComponent1.addSubview(racelengthTitle)
        detailComponent1.addSubview(racelengthResult)
        view.addSubview(detailComponent2)
        detailComponent2.addSubview(raceSpeedTitle)
        detailComponent2.addSubview(raceSpeedResult)
        
        setConstraints()
    }
    
    private func setConstraints() {
        
        resultContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultContainer.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -25).isActive = true
        resultContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.sideMargin).isActive = true
        resultContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -Constants.sideMargin * 2).isActive = true
        
        raceTimeLabel.centerXAnchor.constraint(equalTo: resultContainer.centerXAnchor).isActive = true
        raceTimeLabel.topAnchor.constraint(equalTo: resultContainer.topAnchor, constant: Constants.sideMargin).isActive = true
        raceTimeLabel.heightAnchor.constraint(equalTo: resultContainer.heightAnchor, multiplier: 0.1).isActive = true
        raceTimeLabel.widthAnchor.constraint(equalTo: resultContainer.widthAnchor).isActive = true
        
        raceTimeSeconds.centerXAnchor.constraint(equalTo: resultContainer.centerXAnchor).isActive = true
        raceTimeSeconds.centerYAnchor.constraint(equalTo: resultContainer.centerYAnchor).isActive = true
        raceTimeSeconds.heightAnchor.constraint(equalTo: resultContainer.heightAnchor, multiplier: 0.4).isActive = true
        raceTimeSeconds.widthAnchor.constraint(equalTo: resultContainer.widthAnchor, multiplier: 1/3).isActive = true
        
        raceTimeHundreths.leadingAnchor.constraint(equalTo: raceTimeSeconds.trailingAnchor).isActive = true
        raceTimeHundreths.centerYAnchor.constraint(equalTo: raceTimeSeconds.centerYAnchor).isActive = true
        raceTimeHundreths.heightAnchor.constraint(equalTo: resultContainer.heightAnchor, multiplier: 0.4).isActive = true
        raceTimeHundreths.widthAnchor.constraint(equalTo: resultContainer.widthAnchor, multiplier: 1/3).isActive = true
        
        raceTimeMinutes.trailingAnchor.constraint(equalTo: raceTimeSeconds.leadingAnchor).isActive = true
        raceTimeMinutes.centerYAnchor.constraint(equalTo: raceTimeSeconds.centerYAnchor).isActive = true
        raceTimeMinutes.heightAnchor.constraint(equalTo: resultContainer.heightAnchor, multiplier: 0.4).isActive = true
        raceTimeMinutes.widthAnchor.constraint(equalTo: resultContainer.widthAnchor, multiplier: 1/3).isActive = true
        
        raceTimeSecondsTitle.centerXAnchor.constraint(equalTo: resultContainer.centerXAnchor).isActive = true
        raceTimeSecondsTitle.topAnchor.constraint(equalTo: raceTimeSeconds.bottomAnchor).isActive = true
        raceTimeSecondsTitle.heightAnchor.constraint(equalTo: resultContainer.heightAnchor, multiplier: 0.1).isActive = true
        raceTimeSecondsTitle.widthAnchor.constraint(equalTo: resultContainer.widthAnchor, multiplier: 1/3).isActive = true
        
        raceTimeHundrethsTitle.leadingAnchor.constraint(equalTo: raceTimeSecondsTitle.trailingAnchor).isActive = true
        raceTimeHundrethsTitle.topAnchor.constraint(equalTo: raceTimeHundreths.bottomAnchor).isActive = true
        raceTimeHundrethsTitle.heightAnchor.constraint(equalTo: resultContainer.heightAnchor, multiplier: 0.1).isActive = true
        raceTimeHundrethsTitle.widthAnchor.constraint(equalTo: resultContainer.widthAnchor, multiplier: 1/3).isActive = true
        
        raceTimeMinutesTitle.trailingAnchor.constraint(equalTo: raceTimeSecondsTitle.leadingAnchor).isActive = true
        raceTimeMinutesTitle.topAnchor.constraint(equalTo: raceTimeMinutes.bottomAnchor).isActive = true
        raceTimeMinutesTitle.heightAnchor.constraint(equalTo: resultContainer.heightAnchor, multiplier: 0.1).isActive = true
        raceTimeMinutesTitle.widthAnchor.constraint(equalTo: resultContainer.widthAnchor, multiplier: 1/3).isActive = true
        
        detailComponent1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideMargin).isActive = true
        detailComponent1.topAnchor.constraint(equalTo: resultContainer.bottomAnchor, constant: Constants.sideMargin).isActive = true
        detailComponent1.heightAnchor.constraint(equalToConstant: Constants.widthOfDisplay * 0.5 - Constants.sideMargin * 3/2).isActive = true
        detailComponent1.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -Constants.sideMargin / 2).isActive = true
        
        racelengthResult.trailingAnchor.constraint(equalTo: detailComponent1.trailingAnchor).isActive = true
        racelengthResult.centerYAnchor.constraint(equalTo: detailComponent1.centerYAnchor).isActive = true
        racelengthResult.heightAnchor.constraint(equalTo: detailComponent1.heightAnchor, multiplier: 0.4).isActive = true
        racelengthResult.leadingAnchor.constraint(equalTo: detailComponent1.leadingAnchor).isActive = true
        
        racelengthTitle.trailingAnchor.constraint(equalTo: detailComponent1.trailingAnchor).isActive = true
        racelengthTitle.bottomAnchor.constraint(equalTo: detailComponent1.bottomAnchor).isActive = true
        racelengthTitle.topAnchor.constraint(equalTo: racelengthResult.bottomAnchor).isActive = true
        racelengthTitle.leadingAnchor.constraint(equalTo: detailComponent1.leadingAnchor).isActive = true
        
        detailComponent2.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.sideMargin / 2).isActive = true
        detailComponent2.topAnchor.constraint(equalTo: resultContainer.bottomAnchor, constant: Constants.sideMargin).isActive = true
        detailComponent2.heightAnchor.constraint(equalToConstant: Constants.widthOfDisplay * 0.5 - Constants.sideMargin * 3/2).isActive = true
        detailComponent2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideMargin).isActive = true
        
        raceSpeedResult.leadingAnchor.constraint(equalTo: detailComponent2.leadingAnchor).isActive = true
        raceSpeedResult.centerYAnchor.constraint(equalTo: detailComponent2.centerYAnchor).isActive = true
        raceSpeedResult.heightAnchor.constraint(equalTo: detailComponent2.heightAnchor, multiplier: 0.4).isActive = true
        raceSpeedResult.trailingAnchor.constraint(equalTo: detailComponent2.trailingAnchor).isActive = true
        
        raceSpeedTitle.leadingAnchor.constraint(equalTo: detailComponent2.leadingAnchor).isActive = true
        raceSpeedTitle.topAnchor.constraint(equalTo: raceSpeedResult.bottomAnchor).isActive = true
        raceSpeedTitle.bottomAnchor.constraint(equalTo: detailComponent2.bottomAnchor).isActive = true
        raceSpeedTitle.trailingAnchor.constraint(equalTo: detailComponent2.trailingAnchor).isActive = true
        
        /*
        seeDetailsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideMargin).isActive = true
        seeDetailsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.sideMargin).isActive = true
        seeDetailsButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.125).isActive = true
        seeDetailsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideMargin).isActive = true
         */
    }
    
    @objc private func saveRace() {
        print("'saving'")
    }
    
    private func setResults() {
        raceTimeHundreths.text = "08"
        raceTimeMinutes.text = "01"
        raceTimeSeconds.text = "42"
        racelengthResult.text = "152"
        raceSpeedResult.text = "32"
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}

