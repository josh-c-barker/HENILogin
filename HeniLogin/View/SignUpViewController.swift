//
//  SignUpViewController.swift
//  HeniLogin
//
//  Created by Josh Barker on 14/01/2022.
//

import UIKit

class SignUpViewController: JHAViewController {

    @IBOutlet private var usernameField: UITextField!
    
    @IBOutlet private var passwordField: UITextField!
    
    @IBOutlet private var confirmField: UITextField!
    
    
    @IBOutlet weak var checkBoxOutlet:UIButton!{
            didSet{
                checkBoxOutlet.setImage(UIImage(named:"unselectedCheckbox"), for: .normal)
                checkBoxOutlet.setImage(UIImage(named:"selectedCheckBox"), for: .selected)
            }
        }
    
    var formIsValid = false
    
    let EMAIL_FIELD = 3
    let PASSWORD_FIELD = 4
    let CONFIRM_PASSWORD_FIELD = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.usernameField.delegate = self
        
        self.passwordField.delegate = self

        self.confirmField.delegate = self

    }
    

    @IBAction func signUpPressed(_ sender: Any) {
        
        if self.formIsValid {
            self.performSegue(withIdentifier: "showMainApp", sender: nil)
        } else {
            self.showUserAlert(msg: "Form is not valid. Please complete the form fully.")
        }
    }
    
    @IBAction func checkbox(_ sender: UIButton){

        sender.checkboxAnimation {
           }
   }
    
    func markFieldInvalid (textField: UITextField) {

        textField.textColor = Colours.validationText
        textField.layer.borderColor = Colours.validationText?.cgColor
        textField.backgroundColor = Colours.validattionBkgrnd
        textField.layer.borderWidth = 1
        
        let placeholder = textField.placeholder ?? ""
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : Colours.validationText as Any])
    }
    
    func markFieldValid (textField: UITextField) {
        
        textField.textColor = Colours.darkHeaderBlack
        textField.backgroundColor = UIColor.white
        textField.layer.borderWidth = 1
        textField.borderColor = Colours.signUpGrey
        
        let placeholder = textField.placeholder ?? ""
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : Colours.labelWhiteColor as Any])

    }
    
    func checkFormValid (textField: UITextField) -> Bool {
        
        if textField.text == nil {
            return false
        }
        
        let textStr = textField.text!
        
        var formValidated = true
        
        switch textField.tag {

        case EMAIL_FIELD:
            
            if Validator.shared.validateEmail (emailStr: textStr) {
                
                self.markFieldValid(textField: self.usernameField)

            } else {
                
                if self.usernameField.text != "" {
                    self.markFieldInvalid(textField: self.usernameField)
                    formValidated = false
                }
            }
            
        case PASSWORD_FIELD:
            
            if Validator.shared.validatePassword (passwordStr: textStr) {
                self.markFieldValid(textField: self.passwordField)
                
                if self.passwordField.text != "" && self.confirmField.text != "" {
                    if self.passwordField.text == self.confirmField.text {
                        self.markFieldValid(textField: self.confirmField)
                    }
                }
                
            } else {
                
                //self.validPasswordLabel.text = "Invalid password!"
                
                if self.passwordField.text != "" {
                    self.markFieldInvalid(textField: self.passwordField)
                    formValidated = false
                }
                
                if self.passwordField.text != "" && self.confirmField.text != "" {
                    
                    if self.passwordField.text != self.confirmField.text {

                        self.markFieldInvalid(textField: self.confirmField)
                        formValidated = false
                        
                    }
                    
                } else {
                    
                }
            }
            
            
        case CONFIRM_PASSWORD_FIELD:
            
            if self.passwordField.text == textStr {
                self.markFieldValid(textField: self.confirmField)
                
            } else {
                
                if self.passwordField.text != "" && self.confirmField.text != "" {
                    self.markFieldInvalid(textField: self.confirmField)
                    formValidated = false
                    
                } else {
                }
            }
            
        default:
            Logging.JLog(message: "WARN : textfield not validated")
        }
        
        return formValidated
    }

}

// PRAGMA MARK: UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.formIsValid = self.checkFormValid (textField: textField)
    }
    
    private func textFieldWillReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
}

