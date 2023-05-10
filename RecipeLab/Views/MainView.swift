//
//  MainView.swift
//  RecipeLab
//
//  Created by Asadbek Nematov on 5/9/23.
//

import SwiftUI
import LoremSwiftum

struct MainView: View {
    @Environment(\.openURL) var openURL
    @Binding var selection: Int

    var body: some View {
        ScrollView {
            HStack {
                // logo
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .aspectRatio(contentMode: .fit)
                    .padding(.leading)
                    .frame(width: 130.0)
                    .padding(.horizontal, 27)
                Spacer()
            }
            .padding(.bottom)
                Spacer()
            VStack{
                Spacer()
                VStack {
                    // headtext
                    
                    Text("Welcome!")
                        .font(.custom("MontserratRoman-SemiBold", size: 35))
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding(.bottom)
                    // text
                    
                    Text(Lorem.words(10))
                        .font(.custom("MontserratRoman-Regular", size: 16))
                        .foregroundColor(Color(uiColor: UIColor(red: 0.67, green: 0.67, blue: 0.67, alpha: 1.00)))
                        .padding(.bottom)
                    
                        Button("Portfolio") {
                            selection = 1
                        }
                        .font(.custom("MontserratRoman-Regular", size: 16))
                        .padding(.all, 15.0)
                        .frame(width: 300.0)
                        .foregroundColor(.black)
                        .background(Color(uiColor: UIColor(red: 0.98, green: 1.00, blue: 0.00, alpha: 1.00)))
                        .cornerRadius(/*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .scenePadding(.horizontal)
                        
                }
                Spacer()
            }
            .padding(.horizontal, 22)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/ .dark/*@END_MENU_TOKEN@*/)
            
                Spacer()
        }
    }
}


struct MainView_Previews: PreviewProvider {
    @State static private var dummySelection = 0
    
    static var previews: some View {
        MainView(selection: $dummySelection)
    }
}
