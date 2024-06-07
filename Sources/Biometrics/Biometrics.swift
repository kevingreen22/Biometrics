//
//  Biometrics.swift
//
//  Created by Kevin Green on 10/11/20.
//

import SwiftUI
import LocalAuthentication

public class Bio {
            
    public class func authenticate(closure: @escaping (Bool) -> ()) {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "To unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                DispatchQueue.main.async {
                    if success {
                        // authenticated successfully
                        closure(true)
                    } else {
                        // there was a problem
                        print("There was a problem authenticating biometrics")
                        closure(false)
                    }
                }
            }
        } else {
            // no biometrics
            print("Biometrics not available")
            closure(false)
        }
    }
}
