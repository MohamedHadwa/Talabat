//
//  ViewController.swift
//  Talabat
//
//  Created by Mohamed Hadwa on 19/02/2023.
//

import UIKit
import Lottie
import Alamofire

class LoginViewController: UIViewController {

    let url = URL(string: "https://socket.jiovaniaff.com/api/v1/guest/login")!
    var iconClick = true
    let animationView = LottieAnimationView()

    @IBOutlet weak var phoneNumberTxt: UITextField!
    
    @IBOutlet weak var passwordTxtFeild: UITextField!
    
    @IBOutlet weak var countryKeyOutlet: UIButton!
    
    @IBOutlet weak var securePasswordOutlet: UIButton!
    
    @IBOutlet weak var registerOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          atrributed()
        
    }
    
    
    @IBAction func forgetPasswordPressed(_ sender: Any) {
        let forgetPassword  = UIStoryboard(name: "ForgetPassword", bundle: nil).instantiateViewController(withIdentifier: "ForgetPassword") as! ForgetPasswordController
        forgetPassword.modalPresentationStyle = .fullScreen
        
        self.present(forgetPassword, animated: true)

    }

    @IBAction func loginBtnPressed(_ sender: Any) {
        
        login(phoneNumber: phoneNumberTxt.text ?? "", password: passwordTxtFeild.text ?? "")
        setupAnimation()
    }
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        let register =  UIStoryboard(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "RegisterId") as! RegisterViewController
        register.modalPresentationStyle = .fullScreen
    
            self.present(register, animated: true)
    }
    
    @IBAction func countryKeyBtnPressed(_ sender: Any) {
    }
    
    @IBAction func secureBtnPressed(_ sender: Any) {
        if iconClick {
               passwordTxtFeild.isSecureTextEntry = false
            
           } else {
               passwordTxtFeild.isSecureTextEntry = true
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
    
    
    func login (phoneNumber:String , password: String ){
        let params:[String : String] = ["phone":phoneNumber ,"password":password ,
                      "device_serial":"10","fcm_token":"10"]
        AF.request(url, method:.post, parameters: params,encoding: JSONEncoding.default) .responseJSON { (response) in
           guard let data = response.data else {return}
            guard let res = try? JSONDecoder().decode(LoginModel.self, from: data) else {return}
            ToastManager.shared.showError(message: res.message!, view: self.view, backgroundColor: .red)
            print(res.message)
         }
    }
    func atrributed (){
        let attributied = NSMutableAttributedString(string: " ليس لديك حساب؟  " ,attributes: [NSAttributedString.Key .font:UIFont(name: "Tajawal", size: 14) ?? .systemFont(ofSize: 14)])
        
        attributied.append(NSAttributedString(string: "تسجيل الآن" ,attributes: [NSAttributedString.Key.font:UIFont(name: "", size: 17) ?? .boldSystemFont(ofSize: 17)]))
        registerOutlet.setAttributedTitle(attributied, for:.normal)
                                                                   
    }

}
