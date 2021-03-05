//
//  StartGateViewController.swift
//  Racer
//
//  Created by Ingrid on 24/02/2021.
//
//

import UIKit

class StartGateViewController: UIViewController {
    
    public static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .long
        formatter.locale = .current
        return formatter
    }()
    
    var partnerId = ""
    var raceId = ""
    
    private var selfSender: Sender? {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return nil
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        
        return Sender(photoURL: "",
               senderId: safeEmail,
               displayName: "")
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    private let startRaceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.accentColor
        button.setTitle("Start Count Down", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapStartCountDown), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    private let testStopRaceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.accentColor
        button.setTitle("Test send stop time", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapStopTime), for: .touchUpInside)
        button.tag = 1
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Start Race"
        view.backgroundColor = Constants.whiteColor
        view.addSubview(scrollView)
        scrollView.addSubview(testStopRaceButton)
        scrollView.addSubview(startRaceButton)
        
        print("at race", partnerId)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.safeAreaLayoutGuide.layoutFrame
        
        testStopRaceButton.frame = CGRect(x: Constants.sideSpacing,
                                     y: scrollView.height - Constants.fieldHeight * 3 - Constants.verticalSpacing,
                                 width: scrollView.width - Constants.sideSpacing * 2,
                                 height: Constants.fieldHeight)
    
        startRaceButton.frame = CGRect(x: Constants.sideSpacing,
                                     y: scrollView.height - Constants.fieldHeight - Constants.verticalSpacing,
                                 width: scrollView.width - Constants.sideSpacing * 2,
                                 height: Constants.fieldHeight)
    }
    
    @objc private func didTapStartCountDown() {
        
        guard let selfSender = self.selfSender,
              let selfraceId = createRaceId() else {
                return
        }
        
        raceId = selfraceId
        
        let startTime = Time(sender: selfSender,
                             timestamp: Date().currentTimeMillis(),
                             raceId: raceId)
        
        
        DatabaseManager.shared.createNewRace(with: partnerId, startTime: startTime, completion: { success in
            if success {
                print ("timestamp sent")
            }
            else {
                print("failed to send")
            }
        })
    }
    
    @objc private func didTapStopTime() {
        
        guard let selfSender = self.selfSender else {
                return
        }
        
        let stopTime = Time(sender: selfSender,
                             timestamp: Date().currentTimeMillis(),
                             raceId: raceId)
        
        DatabaseManager.shared.sendTimestamp(to: raceId, time: stopTime, completion: { success in
            if success {
                print ("stop time sent")
            }
            else {
                print("stop time failed to send")
            }
        })
    }
    
        
    
    private func createRaceId() -> String? {
        // date, otherEmail, selfEmail, int
        guard let currentUserEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            return nil
        }
        
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentUserEmail)
        let safePartnerEmail = DatabaseManager.safeEmail(emailAddress: partnerId)
        
        let dateString = Self.dateFormatter.string(from: Date())
        
        let identifier = "\(safePartnerEmail)_\(safeEmail)_\(dateString)"
        
        print(identifier)
        
        return identifier
    }
    

}

extension Date {
    func currentTimeMillis() -> Double {
        return self.timeIntervalSince1970
    }
}
