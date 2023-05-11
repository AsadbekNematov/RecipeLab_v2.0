//
//  MainView.swift
//  RecipeLab
//
//  Created by Asadbek Nematov on 5/9/23.
//

import SwiftUI
import LoremSwiftum

struct MainView: View {
    @Binding var selection: Int

    var body: some View {
        ScrollView {
                Spacer()
            VStack{
                Spacer()
                VStack {
                    // headtext
                    Spacer()
                    Text("Welcome!")
                        .font(.custom("MontserratRoman-SemiBold", size: 35))
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding(.bottom)
                    
                    Text(Lorem.words(10))
                        .font(.custom("MontserratRoman-Regular", size: 16))
                        .foregroundColor(Color(uiColor: UIColor(red: 0.67, green: 0.67, blue: 0.67, alpha: 1.00)))
                        .padding(.bottom)
                    
                        Button() {
                            selection = 1
                        } label: {
                            Image(systemName: "magnifyingglass")
                            Text("Idenitfy")
                        }
                        .font(.custom("MontserratRoman-Regular", size: 16))
                        .padding(.all, 15.0)
                        .frame(width: 300.0)
                        .foregroundColor(.black)
                        .background(.orange)
                        .cornerRadius(/*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .scenePadding(.horizontal)
                        
                }
            }
            .padding(.horizontal, 22)
            
        }
    }
}


struct MainView_Previews: PreviewProvider {
    @State static private var dummySelection = 0
    
    static var previews: some View {
        MainView(selection: $dummySelection)
    }
}
