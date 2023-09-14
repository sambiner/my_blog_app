//
//  Blog.swift
//  slightly-meatier-bones
//
//  Created by keckuser on 4/2/23.
//

import SwiftUI

struct Blog: View {
    @EnvironmentObject var auth: SlightlyMeatyAuth
    @State var requestLogin = false
    
    var body: some View {
        if let authUI = auth.authUI {
            ArticleList(requestLogin: $requestLogin, articles: [])
                .sheet(isPresented: $requestLogin) {
                    AuthenticationViewController(authUI: authUI)
                }
        } else {
            VStack {
                Text("Sorry, it looks like we aren't set up correctly!")
                    .padding()
                
                Text("Please contact this app's developer for assistance.")
                    .padding()
            }
        }
    }
}

struct Blog_Previews: PreviewProvider {
    static var previews: some View {
        Blog()
            .environmentObject(SlightlyMeatyAuth())
    }
}
