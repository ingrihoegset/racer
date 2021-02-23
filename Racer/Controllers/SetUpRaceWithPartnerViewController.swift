//
//  SetUpRaceWithPartnerViewController.swift
//  Racer
//
//  Created by Ingrid on 23/02/2021.
//

import UIKit

class SetUpRaceWithPartnerViewController: UIViewController {
    
    var partnerId = ""
    
    let  timeStampButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Send Timestamp", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapSendTimeStamp), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        view.addSubview(timeStampButton)

        print("pid", partnerId)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        timeStampButton.frame = CGRect(x: (view.width - 150)/2,
                                       y: (view.height - 150)/2,
                                       width: 150,
                                       height: 150)
    }
    
    @objc func didTapSendTimeStamp() {
        print("Tapped timestamp button")
    }

}
