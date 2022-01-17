//
//  Validator.swift
//  Motif
//
//  Created by Josh Barker on 14/01/2021.
//

import UIKit

class Validator: NSObject {

    static let shared = Validator ()
    
    func validateUserName (nameStr: String) -> Bool {
        
        var isValid = false
    
        if nameStr.count > 0 {
            isValid = true
        }
    
        return isValid
    }


    
    func validateEmail (emailStr: String) -> Bool {
        
        var isValid = false
    
        if emailStr.count > 0 && self.isValidEmail(emailStr) {
            isValid = true
        }
        
        
    
        return isValid
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    
    
    func getUserNameRules () -> String {
    
        return "Your name needs at least one character."
    }
    
    func validatePassword (passwordStr: String) -> Bool {
    
        var isValid = false
    
        let decimalCharacters = CharacterSet.decimalDigits
        let letterChars = CharacterSet.letters

        if passwordStr.rangeOfCharacter(from: decimalCharacters) != nil {
            if passwordStr.rangeOfCharacter(from: letterChars) != nil {
                if passwordStr.count >= 8 {
                    //if passwordStr.hasSpecialCharacters() {
                        isValid = true
                    //}
                }
            }
        }

        return isValid
    }
    
    func getPasswordRules () -> String {
    
        return "Your password needs to be at least 8 characters and have at least one number and uppercase letter."
    }
    
    
}

extension String {
    
    func hasSpecialCharacters() -> Bool {

        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }

        } catch {
            debugPrint(error.localizedDescription)
            return false
        }

        return false
    }
}
