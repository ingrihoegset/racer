//
//  StartGateViewController.swift
//  Racer
//
//  Created by Ingrid on 24/02/2021.
//
//

import UIKit
import AVFoundation

class StartGateViewController: UIViewController {
    
    /// Data information about race
    var partnerId = ""
    var raceId = ""
    
    /// User selected race details
    var userSelectedLaps = 1
    var userSelectedLength = 100
    var userSelectedDelay = 10
    var userSelectedReactionPeriod = 10
    
    /// Objects related to countdown
    var timer = Timer()
    var audioPlayer: AVAudioPlayer?
    var counter = 3
    
    /// Top display elements
    let displayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.accentColorDark
        return view
    }()
    
    let displayLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = Constants.accentColor
        label.layer.cornerRadius = Constants.smallCornerRadius
        label.textAlignment = .center
        label.font = Constants.mainFontLarge
        label.clipsToBounds = true
        label.textColor = .white
        return label
    }()
    
    let displayLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = Constants.accentColor
        label.layer.cornerRadius = Constants.smallCornerRadius
        label.textAlignment = .center
        label.font = Constants.mainFontLarge
        label.clipsToBounds = true
        label.textColor = .white
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.accentColorDark
        button.setTitle("Start Count Down", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Constants.mainFontLarge
        button.addTarget(self, action: #selector(startRace), for: .touchUpInside)
        button.layer.cornerRadius = Constants.smallCornerRadius
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowRadius = 2.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        return button
     }()
    
    let countDownLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Constants.whiteColor
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.font = Constants.countDownFont
        label.layer.cornerRadius = Constants.widthOfDisplay * 0.75 / 2
        label.layer.masksToBounds = true
        return label
    }()
    
    let cancelRaceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.alpha = 0
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Constants.mainFontLarge
        button.layer.cornerRadius = Constants.smallCornerRadius
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowRadius = 2.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(cancelRace), for: .touchUpInside)
        return button
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Start Race"
        view.backgroundColor = Constants.whiteColor
        
        // Add top displays
        view.addSubview(displayView)
        displayView.addSubview(displayLabel1)
        displayView.addSubview(displayLabel2)
        
        // Add other elements to view
        view.addSubview(startButton)
        view.addSubview(countDownLabel)
        view.addSubview(cancelRaceButton)
        
        // Set tekst in top labels
        setDisplayLabelText()
        
        raceId = "race_\(raceId)"

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        displayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        displayView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        displayView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.125).isActive = true
        displayView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        displayLabel1.topAnchor.constraint(equalTo: displayView.topAnchor, constant: Constants.sideMargin / 2).isActive = true
        displayLabel1.trailingAnchor.constraint(equalTo: displayView.centerXAnchor, constant: -Constants.sideMargin / 2).isActive = true
        displayLabel1.bottomAnchor.constraint(equalTo: displayView.bottomAnchor, constant: -Constants.sideMargin).isActive = true
        displayLabel1.widthAnchor.constraint(equalTo: displayView.widthAnchor, multiplier: 0.4).isActive = true
        
        displayLabel2.topAnchor.constraint(equalTo: displayView.topAnchor, constant: Constants.sideMargin / 2).isActive = true
        displayLabel2.leadingAnchor.constraint(equalTo: displayView.centerXAnchor, constant: Constants.sideMargin / 2).isActive = true
        displayLabel2.bottomAnchor.constraint(equalTo: displayView.bottomAnchor, constant: -Constants.sideMargin).isActive = true
        displayLabel2.widthAnchor.constraint(equalTo: displayView.widthAnchor, multiplier: 0.4).isActive = true
        
        startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.sideMargin).isActive = true
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.235/2).isActive = true
        startButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -Constants.sideMargin * 2).isActive = true
        
        countDownLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        countDownLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -Constants.sideMargin).isActive = true
        countDownLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        countDownLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        
        cancelRaceButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.sideMargin).isActive = true
        cancelRaceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cancelRaceButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.235/2).isActive = true
        cancelRaceButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -Constants.sideMargin * 2).isActive = true
    }
    
    /// Set text in top labels
    func setDisplayLabelText() {
        var delay = ""
        if userSelectedLaps == 0 {
            delay = "Delay: " + String(userSelectedDelay)
        }
        else {
            delay = "Delay: " + String(userSelectedDelay)
        }
        
        let length = "Lap length: " + String(userSelectedLength)
     
        displayLabel1.text = delay
        displayLabel2.text = length
    }
    
    
    @objc private func didTapStartTime() {
        
        let currentTime = Date().currentTimeMillis()
        
        DatabaseManager.shared.sendTimestamp(to: raceId, timestamp: currentTime, completion: { success in
            if success {
                print ("stop time sent")
            }
            else {
                print("stop time failed to send")
            }
        })
    }

}

/// Count down related functions
extension StartGateViewController {
    
    @objc private func startRace() {
        counter = userSelectedDelay
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.startButton.alpha = 0
            self.startButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { (_) in
            self.cancelRaceButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.cancelRaceButton.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.cancelRaceButton.alpha = 1
                self.cancelRaceButton.transform = CGAffineTransform.identity
            }
        }
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: .beginFromCurrentState,
            animations: {
                self.countDownLabel.alpha = 1
            },
            completion: { _ in
            }
        )
    }
    
    @objc private func cancelRace() {
        
        timer.invalidate()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.cancelRaceButton.alpha = 0
            self.cancelRaceButton.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }) { (_) in
            self.cancelRaceButton.alpha = 0
            self.startButton.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            self.startButton.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.startButton.alpha = 1
                self.startButton.transform = CGAffineTransform.identity
            }
        }
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: .beginFromCurrentState,
            animations: {
                self.countDownLabel.alpha = 0
                
            },
            completion: { _ in
                self.countDownLabel.text = ""
            }
        )
    }
    
    //Is trigger for every timer interval (1 second)
    @objc private func countDown() {
        print("counting...")
        countDownLabel.text = String(counter)
        countDownLabel.alpha = 1
        countDownLabel.backgroundColor = UIColor(white: 1, alpha: 0.5)
        countDownLabel.backgroundColor = Constants.contrastColor!.withAlphaComponent(0.5)
        if (counter % 10 == 0 && counter > 0) {
            playSound(filename: "shortBeep")
            counter = counter - 1
        }
        else if (counter > 3) {
            counter = counter - 1
        }
        else if (counter <= 3 && counter > 0) {
            playSound(filename: "shortBeep")
            counter = counter - 1
        }
        else {
            playSound(filename: "longBeep")
           // viewModel.startRace(laps: Int16(userSelectedLaps), length: Int32(userSelectedLength), type: type)
            timer.invalidate()
            countDownLabel.text = "GO!"
            counter = 3
        }
        print(counter)
    }

    
    func playSound(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let audioPlayer = audioPlayer else { return }

            audioPlayer.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}



extension Date {
    func currentTimeMillis() -> Double {
        return self.timeIntervalSince1970
    }
}
