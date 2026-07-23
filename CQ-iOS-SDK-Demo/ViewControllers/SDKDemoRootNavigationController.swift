//
//  SDKDemoRootNavigationController.swift
//  CQ-iOS-SDK-Demo
//

import UIKit

final class SDKDemoRootNavigationController: UINavigationController {
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
