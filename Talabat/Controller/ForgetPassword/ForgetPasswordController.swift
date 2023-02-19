//
//  ForgetPasswordController.swift
//  Talabat
//
//  Created by Mohamed Hadwa on 19/02/2023.
//

import UIKit


class ForgetPasswordController: UIViewController {

    
    // MARK: - IBOutlets.
    
    @IBOutlet weak var countryKeyBtn: UIButton!
    
    @IBOutlet weak var phoneTextField: UITextField!
    // MARK: - Private Variables.
    var phoneTextInput = ""
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
    }
    // MARK: - IBActions.
    
    @IBAction func confirmPhoneNumber(_ sender: Any) {
        let forgetPassword  = UIStoryboard(name: "OTP", bundle: nil).instantiateViewController(withIdentifier: "OTPId") as! OTPViewController
        forgetPassword.modalPresentationStyle = .fullScreen
        phoneTextInput = phoneTextField.text ?? ""
        forgetPassword.passData = phoneTextInput
        self.present(forgetPassword, animated: true)

    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        let login  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginId") as! LoginViewController
        login.modalPresentationStyle = .fullScreen
        
        self.present(login, animated: true)
        
    }
    
    
    // MARK: - Private Functions.
  
    
    
}

//// MARK: - APi.
//
//extension <#UIviewController#> {
//
//
//
//}


