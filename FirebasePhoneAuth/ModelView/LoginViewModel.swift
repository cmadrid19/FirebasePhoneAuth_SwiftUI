//
//  LoginView.swift
//  FirebasePhoneAuth
//
//  Created by Maxim Macari on 11/11/2020.
//

import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {
    @Published var phoneNumber = "" {
        didSet {
            if phoneNumber.count > phoneLimitChar && oldValue.count <= phoneLimitChar {
                phoneNumber = oldValue
            }
        }
    }
    private let phoneLimitChar = 9
    
    @Published var code = ""
    
    
    //Data model for error view
    @Published var errorMessage = ""
    @Published var error = false
    
    //storing code for verification
    @Published var CODE = ""
    @Published var goToVerify = false
    
    //User logged in Status
    @AppStorage("logStatus") var logStatus = false
    
    //Loading view...
    @Published var loading = false
    
    //getting county phone code
    func getCountryPhoneNumber() -> String {
        
        let regionCode = Locale.current.regionCode ?? ""
        
        let countryCode = contries[regionCode] ?? ""
        
        return ("+\(countryCode)")
    }
    
    
    //send code to user
    func sendCode() {
        //Enabling testing code..
        //Disable when you nees to test with real device
        //        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        
        
        let number = "\(getCountryPhoneNumber())\(phoneNumber)"
        print("number sent: \(number)")
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (code, error) in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.error.toggle()
                return
            }
            self.CODE = code ?? ""
            self.goToVerify = true
            
        }
        
    }
    
    func verifyCode() {
        let credentials = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code)
        
        loading = true
        
        Auth.auth().signIn(with: credentials) { (resul, error) in
            
            self.loading = false
            
            if let error = error {
                self.errorMessage = error.localizedDescription
                
                withAnimation(){
                    self.error.toggle()
                }
                return
            }
            
            //else user succesfully logs in
            withAnimation(){
                self.logStatus = true
            }
        }
    }
    
    func requestCode(){
        sendCode()
        withAnimation(){
            self.errorMessage = "Code sent successfully!"
            self.error.toggle()
        }
    }
}

