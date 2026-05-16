//
//  StartInspectionViewController.swift
//  CQ-iOS-SDK-Demo
//
//  Created by Sanket on 08/04/24.
//

import UIKit
import ClearQuoteSDK

class StartInspectionViewController: UIViewController {
    // Outlets
    // Client attrs
    @IBOutlet private weak var ipUserName: UITextField!
    @IBOutlet private weak var ipDealer: UITextField!
    @IBOutlet private weak var ipDealerIdentifier: UITextField!
    @IBOutlet private weak var ipClientUniqueId: UITextField!
    
    // Input details
    @IBOutlet private weak var ipRegNumber: UITextField!
    @IBOutlet private weak var ipMake: UITextField!
    @IBOutlet private weak var ipModel: UITextField!
    @IBOutlet private weak var ipBodyStyle: UITextField!
    @IBOutlet private weak var ipVariant: UITextField!
    @IBOutlet private weak var ipFuelType: UITextField!
    @IBOutlet private weak var ipInspectionType: UITextField!
    @IBOutlet private weak var ipFleetImageType: UITextField!
    @IBOutlet private weak var ipCustomerName: UITextField!
    @IBOutlet private weak var ipCustomerEmail: UITextField!
    @IBOutlet private weak var ipDialCode: UITextField!
    @IBOutlet private weak var ipPhoneNumber: UITextField!
    
    
    // Others
    @IBOutlet private weak var lbDealerCode: UILabel!
    @IBOutlet private weak var lbUsername: UILabel!
    @IBOutlet private weak var lbSdkKey: UILabel!
    @IBOutlet private weak var lbDemoAppVersion: UILabel!
    @IBOutlet private weak var lbCQSDKVersion: UILabel!
    @IBOutlet weak var offlineSwitch: UISwitch!
    
    // Temp for Offline work
    var isOffline = false
    
    // Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View
        setupView()

        #if DEBUG
        ipUserName.text = "tegdealeradmin"
        ipDealer.text = "TEG_Integration"
        #endif
    }
    
    private func setupView() {
        // Hide navigation controller back button
        UIUtils.shared.hideBackButtonInNavigationController(classRef: self)
        
        // Populate dealer code
        lbDealerCode.text = "Dealer Code: \(ClearQuote.shared.getCurrentDealerCode() ?? "")"
        
        // Populate user name
        lbUsername.text = "Username: \(ClearQuote.shared.getCurrentUserName() ?? "")"
        
        // SDK key
        lbSdkKey.text = "Sdk key: \(ClearQuote.shared.getCurrentSDKKey())"
        
        // Demo app version
        lbDemoAppVersion.text = "Demo App version: \(Utils.shared.getAppVersion())"
        
        // CQ SDK version
        lbCQSDKVersion.text = "CQ SDK Version: \(ClearQuote.shared.getCurrentSDKVersion())"
        
        // Set keyboard type for dial code and phone number
        ipPhoneNumber.keyboardType = .phonePad
        ipDialCode.keyboardType = .phonePad
    }
    
    /*
     * MARK: Execute if switch mode is change
     */
    @IBAction private func onChangeOfflineSwitchValue(_ sender: UISwitch) {
        ClearQuote.shared.isOffline = sender.isOn
        isOffline = ClearQuote.shared.isOffline
    }
    
    // Actions
    @IBAction private func onClickBtnStartInspection() {
        // Create client attrs
        let clientAttrs = CQSDKClientAttrs(
            userName: ipUserName.text ?? "",
            dealer: ipDealer.text ?? "",
            dealerIdentifier: ipDealerIdentifier.text ?? "",
            client_unique_id: ipClientUniqueId.text ?? ""
        )
        
        // Create input details
        let inputDetails = CQSDKInputDetails(
            customerDetails: CQSDKCustomerDetails(
                name: ipCustomerName.text ?? "",
                email: ipCustomerEmail.text ?? "",
                dialCode: ipDialCode.text ?? "",
                phoneNumber: ipPhoneNumber.text ?? ""
            ),
            vehicleDetails: CQSDKVehicleDetails(
                regNumber: ipRegNumber.text?.trimmingCharacters(in: .whitespaces) ?? "",
                make: ipMake.text ?? "",
                model: ipModel.text ?? "",
                bodyStyle: ipBodyStyle.text ?? "",
                fuelType: ipFuelType.text ?? "",
                variant: ipVariant.text ?? ""
            ),
            quoteData: CQSDKQuoteData(
                inspectionType: ipInspectionType.text ?? "",
                fleetImageType: ipFleetImageType.text ?? ""
            )
        )
        
        // Start inspection
        ClearQuote.shared.startInspection(
            baseVC: self,
            clearQuoteSdkDelegate: self,
            clientAttrs: clientAttrs,
            inputDetails: inputDetails,
            userFlowParams: nil,
            result: { inspectionStarted, message, code in
                if (!inspectionStarted) {
                    // Get labels
                    let t1 = "Inspection Started : \(inspectionStarted)"
                    let t2 = "Message : \(message)"
                    let t3 = "Code : \(code)"
                    
                    // Open the dialog
                    UIUtils.shared.openInspectionResultDialog(
                        baseVC: self,
                        t1: t1,
                        t2: t2,
                        t3: t3
                    )
                }
            }
        )
    }
    
    @IBAction private func onClickBtnStartInspectionSkipInput() {
        if isOffline {
            // Create client attrs
            let clientAttrs = CQSDKClientAttrs(
                userName: ipUserName.text ?? "",
                dealer: ipDealer.text ?? "",
                dealerIdentifier: ipDealerIdentifier.text ?? "",
                client_unique_id: ipClientUniqueId.text ?? ""
            )
            
            // Create input details
            let inputDetails = CQSDKInputDetails(
                customerDetails: CQSDKCustomerDetails(
                    name: ipCustomerName.text ?? "",
                    email: ipCustomerEmail.text ?? "",
                    dialCode: ipDialCode.text ?? "",
                    phoneNumber: ipPhoneNumber.text ?? ""
                ),
                vehicleDetails: CQSDKVehicleDetails(
                    regNumber: ipRegNumber.text?.trimmingCharacters(in: .whitespaces) ?? "",
                    make: ipMake.text ?? "",
                    model: ipModel.text ?? "",
                    bodyStyle: ipBodyStyle.text ?? "",
                    fuelType: ipFuelType.text ?? "",
                    variant: ipVariant.text ?? ""
                ),
                quoteData: CQSDKQuoteData(
                    inspectionType: ipInspectionType.text ?? "",
                    fleetImageType: ipFleetImageType.text ?? ""
                )
            )
            
            // Create user flow params
            let userFlowParams = CQSDKUserFlowParams(
                isOffline: true,
                skipInputPage: true
            )
            
            // Start inspection
            ClearQuote.shared.startInspection(
                baseVC: self,
                clearQuoteSdkDelegate: self,
                clientAttrs: clientAttrs,
                inputDetails: inputDetails,
                userFlowParams: userFlowParams,
                result: { inspectionStarted, message, code in
                    if (!inspectionStarted) {
                        // Get labels
                        let t1 = "Inspection Started : \(inspectionStarted)"
                        let t2 = "Message : \(message)"
                        let t3 = "Code : \(code)"
                        
                        // Open the dialog
                        UIUtils.shared.openInspectionResultDialog(
                            baseVC: self,
                            t1: t1,
                            t2: t2,
                            t3: t3
                        )
                    }
                }
            )
            
        } else {
            // Create client attrs
            let clientAttrs = CQSDKClientAttrs(
                userName: ipUserName.text ?? "",
                dealer: ipDealer.text ?? "",
                dealerIdentifier: ipDealerIdentifier.text ?? "",
                client_unique_id: ipClientUniqueId.text ?? ""
            )
            
            // Create input details
            let inputDetails = CQSDKInputDetails(
                customerDetails: CQSDKCustomerDetails(
                    name: ipCustomerName.text ?? "",
                    email: ipCustomerEmail.text ?? "",
                    dialCode: ipDialCode.text ?? "",
                    phoneNumber: ipPhoneNumber.text ?? ""
                ),
                vehicleDetails: CQSDKVehicleDetails(
                    regNumber: ipRegNumber.text?.trimmingCharacters(in: .whitespaces) ?? "",
                    make: ipMake.text ?? "",
                    model: ipModel.text ?? "",
                    bodyStyle: ipBodyStyle.text ?? "",
                    fuelType: ipFuelType.text ?? "",
                    variant: ipVariant.text ?? ""
                ),
                quoteData: CQSDKQuoteData(
                    inspectionType: ipInspectionType.text ?? "",
                    fleetImageType: ipFleetImageType.text ?? ""
                )
            )
            
            // Create user flow params
            let userFlowParams = CQSDKUserFlowParams(
                isOffline: false,
                skipInputPage: true
            )
            
            // Start inspection
            ClearQuote.shared.startInspection(
                baseVC: self,
                clearQuoteSdkDelegate: self,
                clientAttrs: clientAttrs,
                inputDetails: inputDetails,
                userFlowParams: userFlowParams,
                result: { inspectionStarted, message, code in
                    if (!inspectionStarted) {
                        // Get labels
                        let t1 = "Inspection Started : \(inspectionStarted)"
                        let t2 = "Message : \(message)"
                        let t3 = "Code : \(code)"
                        
                        // Open the dialog
                        UIUtils.shared.openInspectionResultDialog(
                            baseVC: self,
                            t1: t1,
                            t2: t2,
                            t3: t3
                        )
                    }
                }
            )
        }
    }
    
    @IBAction private func onClickBtnManualSync() {
        ClearQuote.shared.initiateOfflineInspectionsSync()
    }
    
    @IBAction private func onClickBtnLogout() {
        // Logout from CQ SDK
        ClearQuote.shared.logout()
        
        // Clear preferences from demo app
        DemoAppDefaults.shared.clearAll()
        
        // Navigate to main page
        UIUtils.shared.navigateTo(
            classRef: self,
            storyBoard: Storyboards.main.asStoryBoard(),
            viewControllerId: ViewControllers.SDKDemoAppMainViewController.rawValue
        )
    }
}

extension StartInspectionViewController: ClearQuoteSDKDelegate {
    func inspectionCompletionStatus(identifier: String, message: String, code: Int, isOffline: Bool, serverQuoteId: String?, serverInspectionId: String?) {
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.5,
            execute:  {
                // Open the inspection start result dialog
                UIUtils.shared.openInspectionResultDialog(
                    baseVC: self,
                    t1: "Identifier : \(identifier)",
                    t2: "Message : \(message)",
                    t3: "Code : \(code)"
                )
            }
        )
    }
}
