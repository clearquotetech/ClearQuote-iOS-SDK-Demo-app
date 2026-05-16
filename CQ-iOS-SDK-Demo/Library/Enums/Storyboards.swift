//
//  Storyboards.swift
//  CQ-iOS-SDK-Demo
//
//  Created by Sanket on 09/04/24.
//

import Foundation
import UIKit

enum Storyboards: String {
    case main = "Main"
    case customDialogs = "CustomDialogs"
    
    func asStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}
