//
//  AppDefaults.swift
//  CQ-iOS-SDK-Demo
//
//  Created by Sanket on 10/04/24.
//

import Foundation


struct CQSDKDemoAppDefaults: Codable {
}

class DemoAppDefaults {
    static let shared = DemoAppDefaults()
    private let defaults = UserDefaults.standard
    
    private init () {}
    
    // All preferences will be stored in a object
    var preferences: CQSDKDemoAppDefaults? {
        get {
            // Get data
            guard let data = defaults.data(
                forKey: UserDefaultsPreferenceKeys.demoAppPreferences.rawValue
            ) else {
                return nil
            }
            
            // Decode data
            let decoder = JSONDecoder()
            guard let preferences = try? decoder.decode(
                CQSDKDemoAppDefaults.self,
                from: data
            ) else {
                return nil
            }
            
            // Return
            return preferences
        }
        
        set {
            // Encode
            let encoder = JSONEncoder()
            guard let encodedData = try? encoder.encode(
                newValue
            ) else {
                print("Failure while encoding DemoAppDefaults.preferences")
                return
            }
            
            // Set encoded data
            defaults.set(
                encodedData,
                forKey: UserDefaultsPreferenceKeys.demoAppPreferences.rawValue
            )
        }
    }
    
    func clearAll() {
        for caseValue in UserDefaultsPreferenceKeys.allCases {
            defaults.removeObject(
                forKey: caseValue.rawValue
            )
        }
    }
}
