//
//  TabBarController.swift
//  SomeFilms
//
//  Created by Владислав Баранов on 15.07.2024.
//

import Foundation
import SwiftUI

struct TabBarController: View {
    
    @State private var selectedTab = 0


    var body: some View {
        TabView(selection: $selectedTab) {
            ContentView()
                .tabItem {
                    Image(systemName: "house")
                        .font(.system(size: 24))
                        .foregroundColor(Color.gray8C)
                }
                .tag(0)
            
            LikedView()
            .tabItem {
                    Image(systemName: "bookmark")
                        .font(.system(size: 24))
                        .foregroundColor(Color.gray8C)
                }
                .tag(1)
               
        }.onAppear(){
        }
        .accentColor(.red)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    TabBarController()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

