//
//  ViewController.swift
//  CQ-iOS-SDK-Demo
//
//  Created by Abhishek on 04/03/2024.
//

import UIKit
import ClearQuoteSDK

class SDKDemoAppMainViewController: UIViewController {
    @IBOutlet weak var lbDemoAppVersion: UILabel!
    @IBOutlet weak var lbCQSDKVersion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        // Set up view
        setupView()
    }
    
    private func setupView() {
        // Hide navigation controller back button
        UIUtils.shared.hideBackButtonInNavigationController(classRef: self)
        
        // Check if user has already initialized SDK
        checkSdkInitStatus()
        
        // Set demo app version
        lbDemoAppVersion.text = "Demo App version: \(Utils.shared.getAppVersion())"
        
        // Set SDK version
        lbCQSDKVersion.text = "CQ SDK Version: \(ClearQuote.shared.getCurrentSDKVersion())"
    }
    
    private func checkSdkInitStatus() {
        // SDK is initialized already
        if (ClearQuote.shared.isCQSDKInitialized()) {
            if ClearQuote.shared.bodystyleVerificationEnabled {
                ClearQuote.shared.refreshVehicles()
            }
            // Navigate to start inspection page
            UIUtils.shared.navigateTo(
                classRef: self,
                storyBoard: Storyboards.main.asStoryBoard(),
                viewControllerId: ViewControllers.StartInspectionViewController.rawValue
            )
        }
    }
    
    
    // Actions
    @IBAction private func onClickBtnConfigureKey() {
        UIUtils.shared.navigateTo(
            classRef: self,
            storyBoard: Storyboards.main.asStoryBoard(),
            viewControllerId: ViewControllers.SDKInitializationViewController.rawValue
        )
    }
}
