//
//  OTPViewController.swift
//  Talabat
//
//  Created by Mohamed Hadwa on 19/02/2023.
//

import UIKit
import OTPFieldView

 enum UIDisplay {
    
    case verificationCode
    case forgetPassword
}

class OTPViewController: UIViewController {
  
    // MARK: - IBOutlets.
    @IBOutlet weak var changePhoneNumberBtn: UIButton!
    @IBOutlet weak var verificationLbl: UILabel!
    @IBOutlet weak var otpTextView: OTPFieldView!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var resendBtn: UIButton!
    // MARK: - Private Variables.
    var passData = ""
    var totalSecond = 10
    var timer = Timer()
    var isTimerRunning = false
    var typeOfScreen :UIDisplay = .forgetPassword
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        timerLbl.text = "00:00:00"
        setupOtpView()
        runTimer()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayUI(on: typeOfScreen)
        phoneNumberLbl.text = passData


    }
   

    // MARK: - IBActions.
    
    @IBAction func changePhoneNumberBtnPressed(_ sender: Any) {
        if typeOfScreen == .forgetPassword {
            let forgetPasswordVC = UIStoryboard(name: "ForgetPassword", bundle: nil).instantiateViewController(withIdentifier: "ForgetPassword") as! ForgetPasswordController
            forgetPasswordVC.modalPresentationStyle = .fullScreen
            self.present(forgetPasswordVC, animated: true)
        }
        else {
            let register =  UIStoryboard(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "RegisterId") as! RegisterViewController
            register.modalPresentationStyle = .fullScreen
                self.present(register, animated: true)
        }
    }
    
    @IBAction func confirmCodeBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func resendCodeBtnPressed(_ sender: Any) {
        self.totalSecond = 20
        timer.fire()
        runTimer()
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        let loginVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginId") as! LoginViewController
        loginVC.modalPresentationStyle = .fullScreen
        
        self.present(loginVC, animated: true)
        
    }
    
    // MARK: - Private Functions.
    
    func setupOtpView(){
            self.otpTextView.fieldsCount = 4
            self.otpTextView.fieldBorderWidth = 1
            self.otpTextView.defaultBorderColor = UIColor.lightGray
            self.otpTextView.filledBorderColor = UIColor.green
            self.otpTextView.cursorColor = UIColor.red
            self.otpTextView.displayType = .roundedCorner
            self.otpTextView.fieldSize = 60
            self.otpTextView.separatorSpace = 8
            self.otpTextView.shouldAllowIntermediateEditing = false
            self.otpTextView.delegate = self
            self.otpTextView.initializeUI()
            self.otpTextView.otpInputType = .numeric
        }
    func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(OTPViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
               
        if totalSecond < 1 {
                    timer.invalidate()
                    timerLbl.text = "00:00:00 "
                    resendBtn.isEnabled = true
                    isTimerRunning = true

                }
                else {
                    totalSecond -= 1
                    timerLbl.text = prodTimeString(time: TimeInterval(totalSecond))
                    resendBtn.isEnabled = false
                    isTimerRunning = true
                }
    }
   
    func prodTimeString(time: TimeInterval) -> String {
        let prodHours = Int(time) / 60 % 60 % 60
        let prodMinutes = Int(time) / 60 % 60
        let prodSeconds = Int(time) % 60

            return String(format: "%02d:%02d:%02d",prodHours , prodMinutes, prodSeconds )
        }
    
}

// MARK: - OTPViewController Delegate & DataSource.

extension OTPViewController :UITextFieldDelegate , OTPFieldViewDelegate {
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        print(hasEnteredAll)
        return false
    }
    
    func displayUI (on display :UIDisplay) {
        switch display{

        case .verificationCode:

            verificationLbl.text = "تفعيل الحساب"
            
        case .forgetPassword:
            verificationLbl.text = "نسيت كلمة المرور"
        }
        
    }
}


//// MARK: - APi.
//
//extension <#UIviewController#> {
//
//
//
//}



