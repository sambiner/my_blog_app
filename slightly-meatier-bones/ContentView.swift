//
//  ContentView.swift
//  slightly-meatier-bones
//
//  Created by keckuser on 4/2/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) private var phase
    @State private var query = ""
    
    var body: some View {
        Blog()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SlightlyMeatyAuth())
    }
}

/*
 TODO List:
    - Implement working Google Authentication
    - Implement working GitHub Authentication (because it is probably pretty similar to Google Auth)
    - Implement pagination (next and prev page) and a limit of posts per page (maybe 5 - 10, keep it reasonable so we can test it)
    - Implement a searching feature for tags in a post (since they are delimited with a #, maybe when the user types
        a # in the search bar, they can see the most popular tags in a drop down menu, sorted by how many
        posts a tag is in, if it isn't too difficult)
    - Update the tags to make them look better (?)
    - Custom app icon, transitions, animations, perhaps a dark mode option or just switch the app to dark mode
 */
