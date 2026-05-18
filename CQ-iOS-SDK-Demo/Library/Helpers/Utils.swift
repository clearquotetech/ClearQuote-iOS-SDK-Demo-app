//
//  Utils.swift
//  CQ-iOS-SDK-Demo
//
//  Created by Sanket on 11/04/24.
//

import Foundation

class Utils {
    static let shared = Utils()
    
    private init() {}
    
    
    func getAppVersion() -> String {
        guard let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return ""
        }
        
        // Return
        return appVersion
    }
}
