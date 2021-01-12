//
//  ViewController.swift
//  Biometric Authentication Testing
//
//  Created by Prakhar Trivedi on 25/3/20.
//  Copyright © 2020 Prakhar Trivedi. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var authenticateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func authenticateButtonTapped(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate to continue!"
                
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self?.authenticateLabel.text = "You are in!"
                    } else {
                        let alert = UIAlertController(title: "There was an error!", message: "The app failed to authenticate you!😢", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        alert.addAction(okAction)
                        self?.present(alert, animated: true, completion: nil)
                    }
                }
            }
        } else {
            let alert = UIAlertController(title: "There was an error!", message: "Your device is not configured for biometric authentication!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
}

