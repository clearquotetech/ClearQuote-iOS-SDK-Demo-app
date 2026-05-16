//
//  CustomLoadingDialog.swift
//  CQ-iOS-SDK-Demo
//
//  Created by Sanket on 09/04/24.
//

import Foundation
import UIKit
import ClearQuoteSDK

class CustomLoadingDialogViewController: UIViewController{
    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var vwContainer: UIView!
    
    // Message to be shown on dialog
    var message: String = "Loading...".CQLocalized
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start animating loader
        loader.startAnimating()
        
        // Add transparent background
        view.backgroundColor = UIColor.black.withAlphaComponent(0.30)
        vwContainer.backgroundColor = UIColor.black.withAlphaComponent(0.30)
        
        // Set the message
        lbMessage.text = message
    }
    
    // Hide the dialog
    func hide(completion: @escaping () -> () = {}) {
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true) {
                completion()
            }
        }
    }
}

