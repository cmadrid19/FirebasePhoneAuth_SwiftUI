//
//  ContentView.swift
//  FirebasePhoneAuth
//
//  Created by Maxim Macari on 11/11/2020.
//

import SwiftUI


struct ContentView: View {
    @AppStorage("logStatus") var logStatus = false
    var body: some View {
        ZStack{
            if logStatus {
               Home()
            }else{
                NavigationView{
                    Login()
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

