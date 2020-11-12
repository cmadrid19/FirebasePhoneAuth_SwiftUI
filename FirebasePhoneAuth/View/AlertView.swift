//
//  AlertView.swift
//  FirebasePhoneAuth
//
//  Created by Maxim Macari on 12/11/2020.
//

import SwiftUI

struct AlertView: View {
    
    var msg: String
    @Binding var show: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Text("Message")
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            Text(msg)
                .foregroundColor(.gray)
            
            Button(action: {
                //Close popup alert
                show.toggle()
                
            }, label: {
                Text("Close")
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(Color.yellow.opacity(0.8))
                    .cornerRadius(16)
            })
            .frame(alignment: .center) // center the button
        })
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .padding(.horizontal, 25)
        
        //Background dim
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.3).ignoresSafeArea())
    }
}


