//
//  Authentication_Code.swift
//  travel-note
//
//  Created by Владислав Алпеев on 25.10.2020.
//

import UIKit
import FirebaseAuth

class AuthenticationCodeViewController: UIViewController {
    
    var viewModel: AuthentificationViewModelProtocol!{
        didSet {
            viewModel.errorDidChange = { [weak self] viewModel in
                guard let error = viewModel.error else {return}
                error.addAction(UIAlertAction(title: "Ок", style: .default, handler: { (_) in
                    self?.dismiss(animated: true)
                })) //STRINGS:
                self?.present(error, animated: true, completion: nil)
            }
            viewModel.successDidChange = { [weak self] viewModel in
                self.modalTransitionStyle = .coverVertical
                self.dismiss(animated: true, completion: nil)
                let viewController = TabBarController()
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true)
            }
        }
    }
    
    let codeLabel: UILabel = {
        let lable = UILabel(frame:CGRect(x: 0, y: 0, width: 300, height: 100))
        lable.text = "Код подтверждения" //STRINGS:
        lable.font = .systemFont(ofSize: 30, weight: .bold)
        lable.textAlignment = .center
        return lable
    }()
    
    let enterCodeButton: UIButton = {
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
        
        view.addSubview(codeLabel)
        codeLabel.center.x = self.view.center.x
        
        view.addSubview(codeTextField)
        codeTextField.center.x = self.view.center.x
        
        view.addSubview(enterCodeButton)
        enterCodeButton.center.x = self.view.center.x
        enterCodeButton.addTarget(self, action: #selector(enterCode), for: .touchUpInside)
    }
    
    @objc
    func enterCode() {
        
        guard let verificationCode  = codeTextField.text else {return}
        viewModel.sendCode(code: verificationCode)
        
    }
}
