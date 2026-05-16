//
//  Divider.swift
//  CQ-iOS-SDK-Demo
//
//  Created by Sanket on 09/04/24.
//

import Foundation
import UIKit

class DividerView: UIView {
    
    // Override initializer methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    // Setup the view, set background color to red
    private func setupView() {
        backgroundColor = UIColor(named: "divider_color")
    }
}
