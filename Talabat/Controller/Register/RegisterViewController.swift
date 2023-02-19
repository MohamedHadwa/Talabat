//
//  RegisterViewController.swift
//  Talabat
//
//  Created by Mohamed Hadwa on 19/02/2023.
//

import UIKit
import Alamofire
import Lottie
class RegisterViewController: UIViewController {

    
    // MARK: - IBOutlets.
    
    @IBOutlet weak var firstNameTxt: UITextField!
    
    @IBOutlet weak var lastNameTxt: UITextField!
    
    @IBOutlet weak var phoneNumberTxt: UITextField!
    
    @IBOutlet weak var whatsappNumberTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    
    @IBOutlet weak var countryFlagBtnOutlet: UIButton!
    
    @IBOutlet weak var countryKeyLbl: UILabel!
    
    
    
    // MARK: - Private Variables.
    let url = "https://socket.jiovaniaff.com/api/v1/guest/register"
    var iconClick = true
    let animationView = LottieAnimationView()
    var phoneTextInput = ""


    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    // MARK: - IBActions.
    
    @IBAction func securePasswordBtnPressed(_ sender: Any) {
        securePassword()
    }
    
    @IBAction func confirmSecurePasswordBtnPressed(_ sender: Any) {
        securePassword()
        
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        register(email: emailTxt.text ?? "", phoneNumber: phoneNumberTxt.text ?? "", whatsapp: whatsappNumberTxt.text ?? "", password: passwordTxt.text  ?? "", first_name: firstNameTxt.text ?? "" , last_name: lastNameTxt .text ?? "")
        
    }
    
    
    @IBAction func alreadyHaveAccountBtnPressed(_ sender: Any) {
        let login  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginId") as! LoginViewController
        login.modalPresentationStyle = .fullScreen
        
        self.present(login, animated: true)
    }
    
    // MARK: - Private Functions.
    private func securePassword (){
        if iconClick {
               passwordTxt.isSecureTextEntry = false
            confirmPasswordTxt.isSecureTextEntry = false
            
           } else {
               passwordTxt.isSecureTextEntry = true
               confirmPasswordTxt .isSecureTextEntry = true
           }
           iconClick = !iconClick
    }
    func setupAnimation (){
        animationView.animation = .named("loading")
        animationView.loopMode = .loop
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView.center = view.center
        animationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){ [self] in
            animationView.pause()
            animationView.isHidden = true
            
        }
        animationView.isHidden = false
        view.addSubview(animationView)
    }

}

// MARK: - APi.

extension RegisterViewController {
    
    func register(email:String , phoneNumber : String , whatsapp: String , password : String
                  ,first_name:String , last_name: String ) {
        let parms:[String:String] = [ "email" :email , "phone" : phoneNumber , "whatsapp" : whatsapp , "password" :password , "first_name":first_name , "last_name" :last_name ,"department_id" :"1" ,"country_code" :"+20"  , "fcm_token" :"10","device_serial" : "10"]
        AF.request(url, method: .post , parameters: parms,encoding: JSONEncoding.default).responseJSON { (response) in
            guard let data = response.data else{return}
            guard let res =  try? JSONDecoder().decode(RegisterModel.self, from: data) else {return}
            if res.status != 200{
                ToastManager.shared.showError(message: res.message, view: self.view, backgroundColor: .red)
             
            }
            else{
                ToastManager.shared.showError(message: res.message, view: self.view, backgroundColor: .green)
                self.setupAnimation()
                DispatchQueue.main.asyncAfter(deadline: .now() + 5 ){ [self] in
                    let otp  = UIStoryboard(name: "OTP", bundle: nil).instantiateViewController(withIdentifier: "OTPId") as! OTPViewController
                    otp.modalPresentationStyle = .fullScreen
                    otp.typeOfScreen = .verificationCode
                    phoneTextInput = phoneNumberTxt.text ?? ""
                    otp.passData = phoneTextInput
                    self.present(otp, animated: true)
                }
            }
            print(res.message)
    
        }
        
    }



}



