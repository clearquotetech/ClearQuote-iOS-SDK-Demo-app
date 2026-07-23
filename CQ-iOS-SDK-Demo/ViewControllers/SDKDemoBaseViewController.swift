//
//  SDKDemoBaseViewController.swift
//  CQ-iOS-SDK-Demo
//

import UIKit

class SDKDemoBaseViewController: UIViewController {
    override var shouldAutorotate: Bool {
        false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        .portrait
    }
}
