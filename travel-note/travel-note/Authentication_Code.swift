//
//  Authentication_Code.swift
//  travel-note
//
//  Created by Владислав Алпеев on 25.10.2020.
//

import UIKit
import FirebaseAuth

class Authentication_Code: UIViewController {

    @IBOutlet weak var verificationCodeText: UITextField!
    @IBOutlet weak var sendCodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendVerificationCode(_ sender: Any) {
        
        guard let verificationCode  = verificationCodeText.text else {return}
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (success, error) in
            if error == nil{
                print("User is signed in")
            }
            else{
                print("Failed signing")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
