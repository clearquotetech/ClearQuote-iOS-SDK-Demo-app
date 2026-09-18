//
//  StartInspectionViewController.swift
//  CQ-iOS-SDK-Demo
//
//  Created by Sanket on 08/04/24.
//

import UIKit
import ClearQuoteSDK

class StartInspectionViewController: SDKDemoBaseViewController {
    @IBOutlet private weak var lbInputSummary: UILabel!
    @IBOutlet private weak var inputSummaryScrollView: UIScrollView!
    @IBOutlet private weak var lbDemoAppVersion: UILabel!
    @IBOutlet private weak var lbCQSDKVersion: UILabel!
    @IBOutlet weak var offlineSwitch: UISwitch!

    var inspectionInput = SDKInspectionInput()
    var isOffline = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        DispatchQueue.main.async {
            self.checkConfigDownload()
        }
    }

    private func setupView() {
        lbInputSummary.text = inspectionInput.summaryText
        lbDemoAppVersion.text = "Demo App version: \(Utils.shared.getAppVersion())"
        lbCQSDKVersion.text = "CQ SDK Version: \(ClearQuote.shared.getCurrentSDKVersion())"
        inputSummaryScrollView.setContentHuggingPriority(.defaultLow, for: .vertical)
        inputSummaryScrollView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }

    private func presentInspectionResultDialog(
        inspectionStarted: Bool,
        message: String,
        code: Int
    ) {
        guard !inspectionStarted else { return }
        UIUtils.shared.openInspectionResultDialog(
            baseVC: self,
            t1: "Inspection Started : \(inspectionStarted)",
            t2: "Message : \(message)",
            t3: "Code : \(code)"
        )
    }
    
    private func checkConfigDownload() {
        guard ClearQuote.shared.isCQSDKInitialized() else {
            return
        }
        
        ClearQuote.shared.downloadConfigData(
            clientAttributes: inspectionInput.makeClientAttrs(),
            parentVC: self
        ) { [weak self] isSuccess in
            guard let self, !isSuccess else { return }
            self.presentConfigDownloadFailedDialog()
        }
    }

    private func presentConfigDownloadFailedDialog() {
        UIUtils.shared.openInspectionResultDialog(
            baseVC: self,
            t1: "Config Download : Failed",
            t2: "Message : Unable to download the SDK config data",
            t3: "Please check your connection and try again"
        )
    }

    @IBAction private func onChangeOfflineSwitchValue(_ sender: UISwitch) {
        ClearQuote.shared.isOffline = sender.isOn
        isOffline = ClearQuote.shared.isOffline
    }

    @IBAction private func onClickBtnStartInspection() {
        ClearQuote.shared.startInspection(
            baseVC: self,
            clearQuoteSdkDelegate: self,
            clientAttrs: inspectionInput.makeClientAttrs(),
            inputDetails: inspectionInput.makeInputDetails(),
            userFlowParams: nil,
            result: { [weak self] inspectionStarted, message, code in
                self?.presentInspectionResultDialog(
                    inspectionStarted: inspectionStarted,
                    message: message,
                    code: code
                )
            }
        )
    }

    @IBAction private func onClickBtnStartInspectionSkipInput() {
        let userFlowParams = CQSDKUserFlowParams(
            isOffline: isOffline,
            skipInputPage: true
        )

        ClearQuote.shared.startInspection(
            baseVC: self,
            clearQuoteSdkDelegate: self,
            clientAttrs: inspectionInput.makeClientAttrs(),
            inputDetails: inspectionInput.makeInputDetails(),
            userFlowParams: userFlowParams,
            result: { [weak self] inspectionStarted, message, code in
                self?.presentInspectionResultDialog(
                    inspectionStarted: inspectionStarted,
                    message: message,
                    code: code
                )
            }
        )
    }

    @IBAction private func onClickBtnManualSync() {
        ClearQuote.shared.initiateOfflineInspectionsSync()
    }

    @IBAction private func onClickBtnLogout() {
        ClearQuote.shared.logout()
        DemoAppDefaults.shared.clearAll()
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
            execute: {
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
