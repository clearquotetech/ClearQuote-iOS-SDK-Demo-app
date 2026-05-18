//
//  SplashScreenViewController.swift
//  CQ-iOS-SDK-Demo
//
//  Created by Sanket on 08/05/24.
//

import UIKit
import ClearQuoteSDK

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set view
        setupView()
    }
    
    private func setupView() {
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 1.0,
            execute: {
                if (ClearQuote.shared.isCQSDKInitialized()) {
                    UIUtils.shared.navigateTo(
                        classRef: self,
                        storyBoard: Storyboards.main.asStoryBoard(),
                        viewControllerId: ViewControllers.StartInspectionViewController.rawValue
                    )
                } else {
                    UIUtils.shared.navigateTo(
                        classRef: self,
                        storyBoard: Storyboards.main.asStoryBoard(),
                        viewControllerId: ViewControllers.SDKDemoAppMainViewController.rawValue
                    )
                }
            }
        )
    }
}
