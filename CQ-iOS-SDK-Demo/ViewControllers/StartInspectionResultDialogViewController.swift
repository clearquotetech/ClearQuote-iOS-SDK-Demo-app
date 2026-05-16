//
//  StartInspectionResultDialog.swift
//  CQ-iOS-SDK-Demo
//
//  Created by Sanket on 21/08/24.
//

import Foundation
import UIKit

class StartInspectionResultDialogViewController: UIViewController {
    @IBOutlet private weak var lb1: UILabel!
    @IBOutlet private weak var lb2: UILabel!
    @IBOutlet private weak var lb3: UILabel!
    @IBOutlet private weak var vwContainer: UIView!
    
    private var lb1Val: String = ""
    private var lb2Val: String = ""
    private var lb3Val: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Add transparent background
        view.backgroundColor = UIColor.black.withAlphaComponent(0.30)
        vwContainer.backgroundColor = UIColor.black.withAlphaComponent(0.30)
        
        // Set label values
        setLabelsValues()
    }
    
    private func setLabelsValues() {
        lb1.text = lb1Val
        lb2.text = lb2Val
        lb3.text = lb3Val
    }
    
    func setLabels(t1: String, t2: String, t3: String) {
        lb1Val = t1
        lb2Val = t2
        lb3Val = t3
    }
    
    // Hide the dialog
    func dismiss(completion: @escaping () -> () = {}) {
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true) {
                completion()
            }
        }
    }
    
    // Actions
    @IBAction func onBtnClickOkay() {
        dismiss()
    }
}
