//
//  Authentication_Code.swift
//  travel-note
//
//  Created by Владислав Алпеев on 25.10.2020.
//

import UIKit
import FirebaseAuth

class Authentication_Code: UIViewController {
    
    let codeLable: UILabel = {
        let lable = UILabel(frame:CGRect(x: 0, y: 0, width: 300, height: 100))
        lable.text = "Код подтверждения" //STRINGS:
        lable.font = .systemFont(ofSize: 30, weight: .bold)
        lable.textAlignment = .center
        return lable
    }()
    
    let enterCodeButton: UIButton! = {
        let button = UIButton(frame: CGRect(x: 0, y: 120, width: 300, height: 100))
        button.setTitle("Подтвердить", for: .normal) //STRINGS:
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    let codeTextField: UITextField! = {
        let textField = UITextField(frame: CGRect(x: 0, y: 60, width: 103, height: 100))
        textField.placeholder = "Код" //STRINGS:
        textField.textContentType = .oneTimeCode
        textField.keyboardType = .numberPad
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.becomeFirstResponder()
        textField.textAlignment = .center
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(codeLable)
        codeLable.center.x = self.view.center.x
        
        view.addSubview(codeTextField)
        codeTextField.center.x = self.view.center.x
        
        view.addSubview(enterCodeButton)
        enterCodeButton.center.x = self.view.center.x
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
                let errorCode = UIAlertController(title: "Ошибка", message: "Код из СМС не совпадает", preferredStyle: .alert) //STRINGS:
                errorCode.addAction(UIAlertAction(title: "Ок", style: .default, handler: { (_) in
                    self.modalTransitionStyle = .coverVertical
                    self.dismiss(animated: true)
                })) //STRINGS:
                self.present(errorCode, animated: true, completion: nil)
            }
        }
    }
}
