//
//  ViewModel.swift
//  travel-note
//
//  Created by Владислав Алпеев on 06.11.2020.
//

import UIKit
import FirebaseAuth

protocol AuthentificationViewModelProtocol: class {
    
    var error: UIAlertController? {get}
    var errorDidChange: ((AuthentificationViewModelProtocol) -> ())? { get set }
    
    var success: Bool? {get}
    var successDidChange: ((AuthentificationViewModelProtocol) -> ())? { get set }
    
    func sendPhone(phoneNumber: String)
    func sendCode(code: String)
    
}

class AuthentificationViewModel: AuthentificationViewModelProtocol {
    
    var success: Bool? {
        didSet{
            self.successDidChange?(self)
        }
    }
    var successDidChange: ((AuthentificationViewModelProtocol) -> ())?
    
    var error: UIAlertController? {
        didSet{
            self.errorDidChange?(self)
        }
    }
    var errorDidChange: ((AuthentificationViewModelProtocol) -> ())?
    
    
    func sendPhone(phoneNumber: String) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if error == nil{
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                self.success = true
            }
            else{
                let errorPhone = UIAlertController(title: "Ошибка", message: "Не удалось отправить СМС", preferredStyle: .alert) //STRINGS:
                self.error = errorPhone
            }
        }
    }
    
    func sendCode(code: String) {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        
        Auth.auth().signIn(with: credential) { (success, error) in
            if error == nil{
                print("User is signed in")
                self.success = true
            }
            else{
                let errorCode = UIAlertController(title: "Ошибка", message: "Код из СМС не совпадает", preferredStyle: .alert) //STRINGS:
                self.error = errorCode
            }
        }
    }
    
    
}
