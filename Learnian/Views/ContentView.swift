//
//  ContentView.swift
//  LearnUp
//
//  Created by Vincentius Ian Widi Nugroho on 24/07/22.
//

import SwiftUI

struct ContentView: View {
    init(){
        UITabBar.appearance().backgroundColor = UIColor(learnGray)
    }
    
    var body: some View {
        TabView{
            LearningView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Learning")
                }
            LearnedView()
                .tabItem {
                    Image(systemName: "book.closed").foregroundColor(learnBlue)
                Text("Learned")
            }
        }.accentColor(learnBlue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
