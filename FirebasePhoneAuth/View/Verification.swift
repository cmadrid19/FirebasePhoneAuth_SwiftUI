//
//  Verification.swift
//  FirebasePhoneAuth
//
//  Created by Maxim Macari on 11/11/2020.
//

import SwiftUI

struct Verification: View {
    
    @ObservedObject var loginData: LoginViewModel
    @Environment(\.presentationMode) var present
    
    var body: some View {
        ZStack{
            VStack {
                VStack{
                    HStack{
                        Button(action: {
                            present.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "arrow.lefet")
                                .font(.title2)
                                .foregroundColor(.black)
                        })
                        
                        Spacer()
                        
                        Text("Verify phone")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        if loginData.loading{
                            ProgressView()
                        }
                    }
                    .padding()
                    
                    Text("Code sent to \(loginData.phoneNumber)")
                        .foregroundColor(.gray)
                        .padding(.bottom)
                    
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 15){
                        ForEach(0..<6, id: \.self) { num in
                            //displaying code
                            
                            CodeView(code: getCodeAtIndex(index: num))
                        }
                    }
                    .padding()
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: 0)
                    
                    HStack{
                        Text("Didn't receive code? ")
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            loginData.requestCode()
                        }, label: {
                            Text("Request again")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        })
                    }
                    
                    Button(action: {}, label: {
                        Text("Get via call")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    })
                    .padding(.top, 6)
                    
                    Button(action: {
                        loginData.verifyCode()
                    }, label: {
                        Text("Verify and create account")
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color.yellow.opacity(0.8))
                            .cornerRadius(16)
                    })
                    .padding()
                    
                }
                .frame( height: UIScreen.main.bounds.height / 1.8)
                .background(Color.white)
                .cornerRadius(20)
                
                CustomNumberPad(value: $loginData.code, isVerify: true)
            }
            .background(Color.black.opacity(0.2)
                            .ignoresSafeArea(.all, edges: .bottom))
            
            if loginData.error {
                AlertView(msg: loginData.errorMessage, show: $loginData.error)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    //Getting code at each index
    func getCodeAtIndex(index: Int) -> String{
        if loginData.code.count > index {
            let start = loginData.code.startIndex
            
            let current = loginData.code.index(start, offsetBy: index)
            
            return String(loginData.code[current])
        }
        
        return ""
    }
}

struct CodeView: View {
    
    var code: String
    
    var body: some View{
        
        VStack(spacing: 10){
            Text(code)
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.title2)
            //default frame
                .frame(height: 45)
            
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 4)
        }
    }
}
