//
//  ContentView.swift
//  RecipeLab
//
//  Created by Asadbek Nematov on 5/9/23.
//

import SwiftUI
import LoremSwiftum


struct ContentView: View {
    
    @State private var selection = 0
    
    var body: some View {
        
        TabView(selection: $selection) {
            MainView(selection: $selection)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                        .font(.custom("MontserratRoman-Regular", size: 18))
                }
                .tag(0)
            IdentifyView()
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("Identify")
                        .font(.custom("MontserratRoman-Regular", size: 18))
                }
                .tag(1)
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Explore")
                        .font(.custom("MontserratRoman-Regular", size: 18))
                }
                .tag(2)
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                        .font(.custom("MontserratRoman-Regular", size: 18))
                }
                .tag(3)
        }
        .preferredColorScheme(.dark)
        .ignoresSafeArea()
        .accentColor(/*@START_MENU_TOKEN@*/Color(red: 0.981, green: 1.001, blue: -0.002)/*@END_MENU_TOKEN@*/)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        
    }
    
    init(){
        for familyName in UIFont.familyNames{
            print(familyName)
            
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print("--\(fontName)")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
