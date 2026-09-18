//
//  SDKInputViewController.swift
//  CQ-iOS-SDK-Demo
//

import UIKit
import ClearQuoteSDK

struct SDKInspectionInput {
    var userName: String?
    var dealer: String?
    var dealerIdentifier: String?
    var clientUniqueId: String?
    var organisationID: String?
    var regNumber: String?
    var make: String?
    var model: String?
    var bodyStyle: String?
    var variant: String?
    var fuelType: String?
    var inspectionType: String?
    var fleetImageType: String?
    var customerName: String?
    var customerEmail: String?
    var dialCode: String?
    var phoneNumber: String?

    var summaryText: String {
        [
            "Client Attributes",
            "Username: \(displayValue(userName))",
            "Dealer: \(displayValue(dealer))",
            "Dealer Identifier: \(displayValue(dealerIdentifier))",
            "Client Unique Id: \(displayValue(clientUniqueId))",
            "Organisation ID: \(displayValue(organisationID))",
            "",
            "Input details",
            "Registration number: \(displayValue(regNumber))",
            "Make: \(displayValue(make))",
            "Model: \(displayValue(model))",
            "Bodystyle: \(displayValue(bodyStyle))",
            "Variant: \(displayValue(variant))",
            "Fuel Type: \(displayValue(fuelType))",
            "Inspection Type: \(displayValue(inspectionType))",
            "Fleet Image Type: \(displayValue(fleetImageType))",
            "Customer Name: \(displayValue(customerName))",
            "Customer Email: \(displayValue(customerEmail))",
            "Dial Code: \(displayValue(dialCode))",
            "Phone Number: \(displayValue(phoneNumber))"
        ].joined(separator: "\n")
    }

    func makeClientAttrs() -> CQSDKClientAttrs {
        CQSDKClientAttrs(
            userName: userName,
            dealer: dealer,
            dealerIdentifier: dealerIdentifier,
            client_unique_id: clientUniqueId,
            organisationId: organisationID
        )
    }

    func makeInputDetails() -> CQSDKInputDetails {
        CQSDKInputDetails(
            customerDetails: CQSDKCustomerDetails(
                name: customerName,
                email: customerEmail,
                dialCode: dialCode,
                phoneNumber: phoneNumber
            ),
            vehicleDetails: CQSDKVehicleDetails(
                regNumber: regNumber?.trimmingCharacters(in: .whitespaces),
                make: make,
                model: model,
                bodyStyle: bodyStyle,
                fuelType: fuelType,
                variant: variant
            ),
            quoteData: CQSDKQuoteData(
                inspectionType: inspectionType,
                fleetImageType: fleetImageType
            )
        )
    }

    private func displayValue(_ value: String?) -> String {
        guard let value, !value.isEmpty else {
            return "—"
        }
        return value
    }
}

class SDKInputViewController: SDKDemoBaseViewController {
    @IBOutlet private weak var ipUserName: UITextField!
    @IBOutlet private weak var ipDealer: UITextField!
    @IBOutlet private weak var ipDealerIdentifier: UITextField!
    @IBOutlet private weak var ipClientUniqueId: UITextField!
    @IBOutlet private weak var ipOrganisationID: UITextField!
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
    @IBOutlet private weak var lbDealerCode: UILabel!
    @IBOutlet private weak var lbUsername: UILabel!
    @IBOutlet private weak var lbSdkKey: UILabel!
    @IBOutlet private weak var lbDemoAppVersion: UILabel!
    @IBOutlet private weak var lbCQSDKVersion: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        UIUtils.shared.hideBackButtonInNavigationController(classRef: self)
        configureInputFields()
        ipPhoneNumber.keyboardType = .phonePad
        ipDialCode.keyboardType = .phonePad
        lbDealerCode.text = "Dealer Code: \(ClearQuote.shared.getCurrentDealerCode() ?? "")"
        lbUsername.text = "Username: \(ClearQuote.shared.getCurrentUserName() ?? "")"
        lbSdkKey.text = "Sdk key: \(ClearQuote.shared.getCurrentSDKKey())"
        lbDemoAppVersion.text = "Demo App version: \(Utils.shared.getAppVersion())"
        lbCQSDKVersion.text = "CQ SDK Version: \(ClearQuote.shared.getCurrentSDKVersion())"
    }

    private func configureInputFields() {
        let inputFields = [
            ipUserName,
            ipDealer,
            ipDealerIdentifier,
            ipClientUniqueId,
            ipOrganisationID,
            ipRegNumber,
            ipMake,
            ipModel,
            ipBodyStyle,
            ipVariant,
            ipFuelType,
            ipInspectionType,
            ipFleetImageType,
            ipCustomerName,
            ipCustomerEmail,
            ipDialCode,
            ipPhoneNumber
        ]
        for field in inputFields {
            field?.autocorrectionType = .no
            field?.autocapitalizationType = .none
            field?.spellCheckingType = .no
        }
    }

    @IBAction private func onClickBtnNext() {
        let storyboard = Storyboards.main.asStoryBoard()
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: ViewControllers.StartInspectionViewController.rawValue
        ) as? StartInspectionViewController else {
            return
        }
        viewController.inspectionInput = makeInspectionInput()
        navigationController?.pushViewController(viewController, animated: true)
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

    private func makeInspectionInput() -> SDKInspectionInput {
        SDKInspectionInput(
            userName: text(from: ipUserName),
            dealer: text(from: ipDealer),
            dealerIdentifier: text(from: ipDealerIdentifier),
            clientUniqueId: text(from: ipClientUniqueId),
            organisationID: text(from: ipOrganisationID),
            regNumber: text(from: ipRegNumber),
            make: text(from: ipMake),
            model: text(from: ipModel),
            bodyStyle: text(from: ipBodyStyle),
            variant: text(from: ipVariant),
            fuelType: text(from: ipFuelType),
            inspectionType: text(from: ipInspectionType),
            fleetImageType: text(from: ipFleetImageType),
            customerName: text(from: ipCustomerName),
            customerEmail: text(from: ipCustomerEmail),
            dialCode: text(from: ipDialCode),
            phoneNumber: text(from: ipPhoneNumber)
        )
    }

    private func text(from textField: UITextField) -> String? {
        let value = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let value, !value.isEmpty else {
            return nil
        }
        return value
    }
}
