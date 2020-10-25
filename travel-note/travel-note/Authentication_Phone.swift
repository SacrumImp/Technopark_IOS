//
//  Authentication_Phone.swift
//  travel-note
//
//  Created by Владислав Алпеев on 23.10.2020.
//

import UIKit
import FirebaseAuth

class Authentication_Phone: UIViewController {

    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var enterPhone: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendPhone(_ sender: Any) {
        
        guard let sendPhoneNumber = phoneNumber.text else {return}
        
        PhoneAuthProvider.provider().verifyPhoneNumber(sendPhoneNumber, uiDelegate: nil) { (verificationID, error) in
            if error == nil{
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            }
            else{
                //TODO: вывести сообщение об ошибке
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
