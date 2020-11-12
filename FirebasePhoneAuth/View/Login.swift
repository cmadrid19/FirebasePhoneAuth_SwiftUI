//
//  Login.swift
//  FirebasePhoneAuth
//
//  Created by Maxim Macari on 11/11/2020.
//

import SwiftUI

struct Login: View {
    
    @StateObject var loginData = LoginViewModel()
    @State var isSmall = UIScreen.main.bounds.height < 750
    
    var body: some View {
        ZStack{
            VStack {
                VStack{
                    Text("Continue with phone")
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                        .padding()
                    
                    Image("unlock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    
                    Text("You will receive a 4 digit code.")
                        .font( isSmall ? .none : .title2)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    //Mobile numbeer field
                    HStack{
                        VStack(alignment: .leading, spacing: 6, content: {
                            Text("Enter your number")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text("\(loginData.getCountryPhoneNumber()) \(loginData.phoneNumber)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                               
                        })
                        
                        Spacer(minLength: 0)
                        
                        NavigationLink(destination: Verification(loginData: loginData), isActive: $loginData.goToVerify){
                         
                            Text("")
                                .hidden()
                                
                        }
                        
                        Button(action: {
                            loginData.sendCode()
                        }, label: {
                            
                            Text("Continue")
                                .foregroundColor(.black)
                                .padding(.vertical, 18)
                                .padding(.horizontal, 38)
                                .background(Color.yellow.opacity(0.9))
                                .cornerRadius(16)
                        })
                        
                        .disabled(loginData.phoneNumber == "" ? true : false)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
                }
                .frame(
                    height: UIScreen.main.bounds.height / 1.8)
                .background(Color.white)
                .cornerRadius(20)
                
                
                // Custom Number Pad
                CustomNumberPad(value: $loginData.phoneNumber , isVerify: false)
                
            }
            .background(Color.black.opacity(0.1)
                            .ignoresSafeArea(.all, edges: .bottom))
            
            if loginData.error {
                AlertView(msg: loginData.errorMessage, show: $loginData.error)
            }
        }
    }
}



