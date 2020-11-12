//
//  Home.swift
//  FirebasePhoneAuth
//
//  Created by Maxim Macari on 12/11/2020.
//

import SwiftUI
import Firebase

struct Home: View {
    @AppStorage("logStatus") var logStatus = false
    var body: some View {
        VStack(spacing: 16){
            Text("Logged in Succesfully")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.black)
            
            Button(action: {
                //Log out
                do {
                    try Auth.auth().signOut()
                    withAnimation(){
                        logStatus = false
                    }
                }catch let signOutError as NSError{
                    print("Error signing out: ", signOutError.localizedDescription)
                }
                
            }, label: {
                Text("LogOut")
                    .fontWeight(.heavy)
            })
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
