//
//  AuthenticationModel.swift
//  pin-note
//
//  Created by Владислав Алпеев on 23.11.2020.
//


import FirebaseAuth

protocol AuthProccessorProtocol: class {
    
    func sendPhone(phoneNumber: String, completion: @escaping (User?, NetworkErrors?) -> Void)
    func sendCode(code: String, completion: @escaping (User?, NetworkErrors?) -> Void)
    
}

class AuthProccessor: AuthProccessorProtocol {
    
    
    func sendPhone(phoneNumber: String, completion: @escaping (User?, NetworkErrors?) -> Void) {

        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if error != nil { //TODO: поработать с ошибками
                 completion(nil, .noConnection)
            }
            else {
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                completion(User(phone: phoneNumber, verificationID: "", code: ""), nil)
            }
        }
    }
    
    func sendCode(code: String, completion: @escaping (User?, NetworkErrors?) -> Void) {
        
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        
        Auth.auth().signIn(with: credential) { (success, error) in
            if error != nil{ //TODO: поработать с ошибками
                completion(nil, .noConnection)
            }
            else{
                print("User is signed in")
                completion(User(phone: "", verificationID: verificationID, code: code), nil)
            }
        }
    }
    
    
}
