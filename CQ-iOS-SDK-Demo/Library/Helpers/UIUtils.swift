//
//  UIUtils.swift
//  CQ-iOS-SDK-Demo
//
//  Created by Sanket on 09/04/24.
//

import Foundation
import UIKit

class UIUtils {
    static let shared = UIUtils()
    private init() {}
    
    
    func navigateTo(
        classRef: UIViewController,
        storyBoard: UIStoryboard,
        viewControllerId: String
    ) {
        let viewController = storyBoard.instantiateViewController(withIdentifier: viewControllerId)
        classRef.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    func hideBackButtonInNavigationController(
        classRef: UIViewController
    ) {
        classRef.navigationItem.setHidesBackButton(
            true,
            animated: true
        )
    }
    
    
    func getFullScreenLoader(
        msg: String?
    ) -> CustomLoadingDialogViewController {
        // Instantiate view controller
        let viewController = Storyboards.customDialogs.asStoryBoard().instantiateViewController(withIdentifier: ViewControllers.CustomLoadingDialogViewController.rawValue) as! CustomLoadingDialogViewController
        viewController.message = msg ?? ""
        
        // Set styles
        viewController.modalPresentationStyle = .custom
        viewController.modalTransitionStyle = .crossDissolve
    
        // Return
        return viewController
    }
    
    func openInspectionResultDialog(
        baseVC: UIViewController,
        t1: String,
        t2: String,
        t3: String
    ) {
        DispatchQueue.main.async {
            // Instantiate view controller
            let viewController = Storyboards.customDialogs.asStoryBoard().instantiateViewController(withIdentifier: ViewControllers.StartInspectionResultDialogViewController.rawValue) as! StartInspectionResultDialogViewController
        
            // Set styles
            viewController.modalPresentationStyle = .custom
            viewController.modalTransitionStyle = .crossDissolve
            
            // Set labels
            viewController.setLabels(t1: t1, t2: t2, t3: t3)
            
            // Present
            baseVC.present(
                viewController,
                animated: true
            )
        }
    }
}
