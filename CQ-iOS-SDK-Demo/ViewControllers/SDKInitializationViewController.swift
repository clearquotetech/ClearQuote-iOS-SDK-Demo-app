//
//  SDKInitializationViewController.swift
//  CQ-iOS-SDK-Demo
//
//  Created by Sanket on 08/04/24.
//

import UIKit
import ClearQuoteSDK

class SDKInitializationViewController: SDKDemoBaseViewController {

    @IBOutlet weak var ipSdkKey: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func onClickSaveBtn() {
        // Get SDK key
        let key = ipSdkKey.text?.trimmingCharacters(in: .whitespaces) ?? ""
        
        // Init sdk
        ClearQuote.shared.initSDK(
            baseVC: self,
            key: key,
            result: { isInitialized, code, message in
                // Success
                if (isInitialized) {
                    // Navigate to start inspection page
                    UIUtils.shared.navigateTo(
                        classRef: self,
                        storyBoard: Storyboards.main.asStoryBoard(),
                        viewControllerId: ViewControllers.StartInspectionViewController.rawValue
                    )
                }
                
                // Failure
                else {
                    // Get labels
                    let t1 = "Is ClearQuote SDK Initialized: \(isInitialized)"
                    let t2 = "Message : \(message)"
                    let t3 = "Code : \(code)"
                    
                    // Open the dialog
                    UIUtils.shared.openInspectionResultDialog(
                        baseVC: self,
                        t1: t1,
                        t2: t2,
                        t3: t3
                    )
                }
            }
        )
    }
}
