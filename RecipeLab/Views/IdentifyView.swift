//
//  IdentifyView.swift
//  RecipeLab
//
//  Created by Asadbek Nematov on 5/9/23.
//

import SwiftUI

struct IdentifyView: View {
    @Environment(\.openURL) var openURL
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    // logo
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .aspectRatio(contentMode: .fit)
                        .padding(.leading)
                        .frame(width: 130.0)
                    Spacer()
                }
                .padding(.bottom)
                VStack {
                    // Headlines
                    Text("Portfolio")
                        .font(.custom("MontserratRoman-Bold", size: 36))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    // subhead
                    Text("Awesome Projects")
                        .font(.custom("MontserratRoman-Regular", size: 20))
                        .foregroundColor(Color(hue: 0.173, saturation: 0.888, brightness: 0.855))
                        .padding(.bottom, 40.0)
                }
                .padding(.bottom)
                VStack {
                    VStack {
                        // Google Clone
                        Image("Google")
                            .resizable()
                            .cornerRadius(10)
                            .aspectRatio(contentMode: .fit)
                            .padding(.bottom, 25.0)
                            .frame(width: 360.0)
                            .shadow(color: .gray, radius: 10)
                        Text("Google Clone")
                            .font(.custom("MontserratRoman-SemiBold", size: 28))
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 10.0)
                            .frame(width: 350.0)
                        Text("Google Clone with Google Search API. Used technologies: ReactJS and Redux")
                            .font(.custom("MontserratRoman-Regular", size: 20))
                            .foregroundColor(Color(red: 0.667, green: 0.667, blue: 0.667))
                            .multilineTextAlignment(.leading)
                            .padding(.bottom)
                            .frame(width: 350.0)
                        Button {
                            openURL(URL(string: "https://googleclone-uz.netlify.app/")!)
                        } label: {
                            Label("Demo", systemImage: "link")
                        }
                        .padding(.all, 15.0)
                        .frame(width: 120.0)
                        .foregroundColor(.black)
                        .background(Color(uiColor: UIColor(red: 0.98, green: 1.00, blue: 0.00, alpha: 1.00)))
                        .cornerRadius(/*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .scenePadding(.horizontal)
                    }
                    Spacer()
                }
                .padding(.bottom, 80.0)
                
                VStack {
                    // Phoenix Portfolio
                    Image("Phoenix")
                        .resizable()
                        .cornerRadius(10)
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 25.0)
                        .frame(width: 360.0)
                        .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.500), radius: 10)
                    Text("Phoenix Portfolio")
                        .font(.custom("MontserratRoman-SemiBold", size: 28))
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 10.0)
                        .frame(width: 350.0)
                    Text("My first Portfolio Website, Phoenix, that I created in 2020. Used technologies: Html, CSS, JavaScript, and libraries such as Bootstrap and ReactJS.")
                        .font(.custom("MontserratRoman-Regular", size: 20))
                        .foregroundColor(Color(red: 0.667, green: 0.667, blue: 0.667))
                        .multilineTextAlignment(.leading)
                        .padding(.bottom)
                        .frame(width: 350.0)
                    Button { openURL(URL(string: "https://phoenix-a.uz/")!)
                    } label: {
                        Label("Demo", systemImage: "link")
                    }
                    .padding(.all, 15.0)
                    .frame(width: 120.0)
                    .foregroundColor(.black)
                    .background(Color(uiColor: UIColor(red: 0.98, green: 1.00, blue: 0.00, alpha: 1.00)))
                    .cornerRadius(/*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .scenePadding(.horizontal)
                }
                .padding(.bottom, 80.0)
                VStack {
                    // Task dashboard
                    Image("Tax")
                        .resizable()
                        .cornerRadius(10)
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 25.0)
                        .frame(width: 360.0)
                        .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.500), radius: 10)
                    
                    Text("Task Dashboard")
                        .font(.custom("MontserratRoman-SemiBold", size: 28))
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 10.0)
                        .frame(width: 350.0)
                    Text("Task dashboard with API, Responsive design. Used technology: React.")
                        .font(.custom("MontserratRoman-Regular", size: 20))
                        .foregroundColor(Color(red: 0.667, green: 0.667, blue: 0.667))
                        .multilineTextAlignment(.leading)
                        .padding(.bottom)
                        .frame(width: 350.0)
                    Button {
                        openURL(URL(string: "https://task-dashboard1.netlify.app/")!)
                    } label: {
                        Label("Demo", systemImage: "link")
                    }
                    .padding(.all, 15.0)
                    .frame(width: 120.0)
                    .foregroundColor(.black)
                    .background(Color(uiColor: UIColor(red: 0.98, green: 1.00, blue: 0.00, alpha: 1.00)))
                    .cornerRadius(/*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .scenePadding(.horizontal)
                }
                .padding(.bottom, 80.0)
                
                VStack {
                    // Cloudcash Dashboard
                    Image("Cloudcash")
                        .resizable()
                        .cornerRadius(10)
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 25.0)
                        .frame(width: 360.0)
                        .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.500), radius: 10)
                    
                    Text("Cloudcash Dashboard")
                        .font(.custom("MontserratRoman-SemiBold", size: 28))
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 10.0)
                        .frame(width: 350.0)
                    Text("Cloud cash dashboard with API, Responsive design. Used technology: ReactJS.")
                        .font(.custom("MontserratRoman-Regular", size: 20))
                        .foregroundColor(Color(red: 0.667, green: 0.667, blue: 0.667))
                        .multilineTextAlignment(.leading)
                        .padding(.bottom)
                        .frame(width: 350.0)
                    Button {
                        openURL(URL(string: "https://cloudcash.netlify.app/")!)
                    } label: {
                        Label("Demo", systemImage: "link")
                    }
                    .padding(.all, 15.0)
                    .frame(width: 120.0)
                    .foregroundColor(.black)
                    .background(Color(uiColor: UIColor(red: 0.98, green: 1.00, blue: 0.00, alpha: 1.00)))
                    .cornerRadius(/*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .scenePadding(.horizontal)
                }
                .padding(.bottom, 80.0)
                VStack {
                    // Music maker
                    Image("Music")
                        .resizable()
                        .cornerRadius(10)
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 25.0)
                        .frame(width: 360.0)
                        .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.500), radius: 10)
                    
                    Text("Music Maker")
                        .font(.custom("MontserratRoman-SemiBold", size: 28))
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 10.0)
                        .frame(width: 350.0)
                    Text("Create sounds with just one tap. Used technologies: HTML, CSS, JavaScript.")
                        .font(.custom("MontserratRoman-Regular", size: 20))
                        .foregroundColor(Color(red: 0.667, green: 0.667, blue: 0.667))
                        .multilineTextAlignment(.leading)
                        .padding(.bottom)
                        .frame(width: 350.0)
                    Button {
                        openURL(URL(string: "https://musicmaker-js.netlify.app/")!)
                    } label: {
                        Label("Demo", systemImage: "link")
                    }
                    .padding(.all, 15.0)
                    .frame(width: 120.0)
                    .foregroundColor(.black)
                    .background(Color(uiColor: UIColor(red: 0.98, green: 1.00, blue: 0.00, alpha: 1.00)))
                    .cornerRadius(/*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .scenePadding(.horizontal)
                }
                .padding(.bottom, 80.0)
                VStack {
                    // Recipe
                    Image("Recipe")
                        .resizable()
                        .cornerRadius(10)
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 25.0)
                        .frame(width: 360.0)
                        .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.500), radius: 10)
                    Text("Recipe")
                        .font(.custom("MontserratRoman-SemiBold", size: 28))
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 10.0)
                        .frame(width: 350.0)
                    Text("Recipe app with Edamam API. Used technology: React.")
                        .font(.custom("MontserratRoman-Regular", size: 20))
                        .foregroundColor(Color(red: 0.667, green: 0.667, blue: 0.667))
                        .multilineTextAlignment(.leading)
                        .padding(.bottom)
                        .frame(width: 350.0)
                    Button { openURL(URL(string: "https://recipeapp1.netlify.app/")!)
                    } label: {
                        Label("Demo", systemImage: "link")
                    }
                    .padding(.all, 15.0)
                    .frame(width: 120.0)
                    .foregroundColor(.black)
                    .background(Color(uiColor: UIColor(red: 0.98, green: 1.00, blue: 0.00, alpha: 1.00)))
                    .cornerRadius(/*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .scenePadding(.horizontal)
                }
                .padding(.bottom, 100.0)
            }
        }
        .preferredColorScheme(/*@START_MENU_TOKEN@*/ .dark/*@END_MENU_TOKEN@*/)
        .scrollIndicators(/*@START_MENU_TOKEN@*/ .hidden/*@END_MENU_TOKEN@*/, axes: /*@START_MENU_TOKEN@*/[.vertical, .horizontal]/*@END_MENU_TOKEN@*/)
        .scrollContentBackground(/*@START_MENU_TOKEN@*/ .automatic/*@END_MENU_TOKEN@*/)
        
    }
}

struct IdentifyView_Previews: PreviewProvider {
    static var previews: some View {
        IdentifyView()
    }
}
