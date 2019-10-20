//
//  Alert.swift
//  AdapterDigital
//
//  Created by Kolathee Payuhawatthana on 21/10/19.
//  Copyright © 2019 Kolathee Payuhawatthana. All rights reserved.
//

import UIKit
import PopupDialog

typealias CompletionHandler = () -> Void

class Alert {

    static func error(title: String, message: String, button: String) -> UIViewController {
        
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.titleFont = .boldSystemFont(ofSize: 17)
        dialogAppearance.messageFont = .systemFont(ofSize: 17)

        let popup = PopupDialog(title: title,
                                message: message,
                                transitionStyle: .zoomIn)
        let buttonOne = CancelButton(title: button) {}
        
        popup.addButtons([buttonOne])
        
        return popup
    }
    
    static func delete(title: String, message: String, confirmBTText: String, cancelBTText: String, completionHandler: @escaping CompletionHandler) -> UIViewController {
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.titleFont = .boldSystemFont(ofSize: 17)
        dialogAppearance.messageFont = .systemFont(ofSize: 17)

        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn)
        let confirmButton = DefaultButton(title: confirmBTText) { completionHandler() }
        let cancelButton = CancelButton(title: cancelBTText) {}
        
        popup.addButtons([confirmButton, cancelButton])
        
        return popup
    }
}

