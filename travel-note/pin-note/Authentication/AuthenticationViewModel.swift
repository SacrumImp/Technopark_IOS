//
//  ViewModel.swift
//  travel-note
//
//  Created by Владислав Алпеев on 06.11.2020.
//

import UIKit

enum ViewErrors {
    case noConnection
}

protocol AuthentificationViewModelProtocol: class {
    
    func sendPhone(phoneNumber: String, completion: @escaping (User?, ViewErrors?) -> Void)
    func sendCode(code: String, completion: @escaping (User?, ViewErrors?) -> Void)
    
}

class AuthentificationViewModel: AuthentificationViewModelProtocol {
    
    private var user: User?
    private var authPocessorProtocol: AuthProccessorProtocol!
    
    func sendPhone(phoneNumber: String, completion: @escaping (User?, ViewErrors?) -> Void) {
        authPocessorProtocol = AuthProccessor()
        authPocessorProtocol.sendPhone(phoneNumber: phoneNumber, completion: { [weak self] (user, error) in
            
            guard let self = self else { return }
            
            if error != nil{ //TODO: поработать с ошибками
                completion(nil, .noConnection)
            }
            
            self.user = user
            completion(user, nil)
        })
    }
    
    func sendCode(code: String, completion: @escaping (User?, ViewErrors?) -> Void) {
        authPocessorProtocol = AuthProccessor()
        authPocessorProtocol.sendCode(code: code, completion: { [weak self] (user, error) in
            guard let self = self else { return }
            
            if error != nil{ //TODO: поработать с ошибками
                completion(nil, .noConnection)
            }
            
            self.user = user
            completion(user, nil)
        })
    }
    
    
}
