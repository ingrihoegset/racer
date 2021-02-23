//
//  LinkToPartnerViewController.swift
//  Racer
//
//  Created by Ingrid on 11/02/2021.
//

import UIKit
import JGProgressHUD
import AVFoundation

class LinkToPartnerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var video = AVCaptureVideoPreviewLayer()
    
    var completion: ((String) -> (Void))?
    
    //Create capture session
    let session = AVCaptureSession()
    
    private let spinner = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.mainColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(dismissSelf))
        startCameraSession()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        session.stopRunning()
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
        session.stopRunning()
    }
    
    private func startCameraSession() -> Void {

        //Define capture device
        guard let captureDevice =  AVCaptureDevice.default(for: AVMediaType.video)
        else {
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        }
        catch {
            print("Error establishing video session")
        }
        
        //The output that is going to come out of our session
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        //We are only interested in objects that are of type QR-code
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        //Creating a video representation of what we are doing, i.e. we are showing what we are filming
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        session.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects != nil && metadataObjects.count != 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == AVMetadataObject.ObjectType.qr {
                    guard let partnerId = object.stringValue else {
                        return
                    }
                    
                    // We have the data we need, stop the camera from capturing more frames
                    session.stopRunning()
                    
                    // Dismiss this view controller and pass on data to HomeViewController
                    dismiss(animated: true, completion: { [weak self] in
                        self?.completion?(partnerId)
                    })

                    
                    /*
                    let vc = SetUpRaceWithPartnerViewController()
                    let navVC = UINavigationController(rootViewController: vc)
                    present(navVC, animated: true, completion: {
                    
                        vc.partnerId = partnerId
                    })*/
                    /*
                    let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .cancel, handler: nil))
                    
                    present(alert, animated: true, completion: nil)*/
                }
            }
        }
    }
}

