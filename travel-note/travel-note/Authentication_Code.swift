//
//  Authentication_Code.swift
//  travel-note
//
//  Created by Владислав Алпеев on 25.10.2020.
//

import UIKit
import FirebaseAuth

class Authentication_Code: UIViewController {
    
    let enterCodeButton: UIButton! = {
        let button = UIButton(frame: CGRect(x: 55, y: 330, width: 300, height: 100))
        button.setTitle("Подтвердить", for: .normal) //STRINGS:
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    let codeTextField: UITextField! = {
        let textField = UITextField(frame: CGRect(x: 100, y: 270, width: 400, height: 100))
        textField.placeholder = "Введите код из СМС" //STRINGS:
        textField.textContentType = .oneTimeCode
        textField.keyboardType = .numberPad
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(codeTextField)
        view.addSubview(enterCodeButton)
        enterCodeButton.addTarget(self, action: #selector(enterCode(sender:)), for: .touchUpInside)
    }
    
    @objc func enterCode(sender: UIButton) {
        guard let verificationCode  = codeTextField.text else {return}
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (success, error) in
            if error == nil{
                print("User is signed in")
                self.modalTransitionStyle = .coverVertical
                self.dismiss(animated: true, completion: nil)
            }
            else{
                print("Failed signing") //TODO: Сделать окно для уведомления пользователя о проблемах с авторизацией
            }
        }
    }
}
