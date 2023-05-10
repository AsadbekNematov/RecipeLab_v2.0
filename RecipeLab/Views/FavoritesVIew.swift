//
//  FavoritesVIew.swift
//  RecipeLab
//
//  Created by Asadbek Nematov on 5/9/23.
//

import SwiftUI

struct FavoritesView: View {
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
                Spacer()
            }
            .padding(.bottom)
            VStack{
                VStack {
                    // Headlines
                    Text("FAQs")
                        .font(.custom("MontserratRoman-Bold", size: 36))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    
                    // subhead
                    Text("The most frequently asked questions")
                        .font(.custom("MontserratRoman-Regular", size: 22))
                        .foregroundColor(Color(hue: 0.173, saturation: 0.888, brightness: 0.855))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 40.0)
                }.padding(.bottom)
                // Questions
                VStack {
                    Group {
                        //Question1
                        HStack {
                            Text("What is your name?")
                                .font(.custom("MontserratRoman-SemiBold", size: 28))
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 1)
                                .foregroundColor(Color(hue: 0.173, saturation: 0.888, brightness: 0.855))
                            Spacer()
                        }
                        HStack {
                            Text("I am Asadbek Nematov.")
                                .font(.custom("MontserratRoman-Regular", size: 16))
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 28)
                            Spacer()
                        }
                        //Question2
                        HStack {
                            Text("Where are you from?")
                                .font(.custom("MontserratRoman-SemiBold", size: 28))
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 1)
                                .foregroundColor(Color(hue: 0.173, saturation: 0.888, brightness: 0.855))
                            Spacer()
                        }
                        HStack {
                            Text("I am from Tashkent, Uzbekistan, but currently live in Tampa, Florida.")
                                .font(.custom("MontserratRoman-Regular", size: 16))
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 28)
                            Spacer()
                        }
                        //Question3
                        HStack {
                            Text("How old are you?")
                                .font(.custom("MontserratRoman-SemiBold", size: 28))
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 1)
                                .foregroundColor(Color(hue: 0.173, saturation: 0.888, brightness: 0.855))
                            Spacer()
                        }
                        HStack {
                            Text("I was born on September 29, 2003. Now I am 19 years old.")
                                .font(.custom("MontserratRoman-Regular", size: 16))
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 28)
                            Spacer()
                        }
                        //Question4
                        HStack {
                            Text("Where do you study?")
                                .font(.custom("MontserratRoman-SemiBold", size: 28))
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 1)
                                .foregroundColor(Color(hue: 0.173, saturation: 0.888, brightness: 0.855))
                            Spacer()
                        }
                        HStack {
                            Text("I study at the University of South Florida in Bachelor of Computer Science.")
                                .font(.custom("MontserratRoman-Regular", size: 16))
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 30)
                            Spacer()
                        }
                        //Question5
                        HStack {
                            Text("Are you an iOS or web developer?")
                                .font(.custom("MontserratRoman-SemiBold", size: 28))
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 1)
                                .foregroundColor(Color(hue: 0.173, saturation: 0.888, brightness: 0.855))
                            Spacer()
                        }
                        HStack {
                            Text("My career began in web development. I switched to iOS development after more than a year of working in this field. I can therefore claim to be an iOS developer with a background in web development. ")
                                .font(.custom("MontserratRoman-Regular", size: 16))
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 30)
                            Spacer()
                        }
                    }
                    Group {
                        //Question6
                        HStack {
                            Text("Where did you learn Frontend and iOS development?")
                                .font(.custom("MontserratRoman-SemiBold", size: 28))
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 1)
                                .foregroundColor(Color(hue: 0.173, saturation: 0.888, brightness: 0.855))
                            Spacer()
                        }
                        HStack {
                            Text("I learned them mostly from YouTube and other sources. I also follow some developers from Uzbekistan and around the world on social media.")
                                .font(.custom("MontserratRoman-Regular", size: 16))
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 30)
                            Spacer()
                        }
                        //Question7
                        HStack {
                            Text("Why did you choose the IT sphere?")
                                .font(.custom("MontserratRoman-SemiBold", size: 28))
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 1)                                .foregroundColor(Color(hue: 0.173, saturation: 0.888, brightness: 0.855))
                            Spacer()
                        }
                        HStack {
                            Text("Because I do enjoy programming. I can only truly be myself when I'm coding. Coding makes me connect with the universe. I also think that success in a profession comes from a person doing what they love.")
                                .font(.custom("MontserratRoman-Regular", size: 16))
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 30)
                            Spacer()
                        }
                        //Question8
                        HStack {
                            Text("How can we contact you?")
                                .font(.custom("MontserratRoman-SemiBold", size: 28))
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 1)
                                .foregroundColor(Color(hue: 0.173, saturation: 0.888, brightness: 0.855))
                            Spacer()
                        }
                        HStack {
                            Text("You can contact me via any social media that I left on the home page, or send me an email at asadbekn443@gmail.com. Do not hesitate to reach out!")
                                .font(.custom("MontserratRoman-Regular", size: 16))
                                .multilineTextAlignment(.leading)
                                .padding(.bottom)
                            Spacer()
                        }.padding(.bottom, 50.0)
                    }
                }.padding(.bottom, 50)
                // Questions end
            }
            .padding(.horizontal, 30)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/ .dark/*@END_MENU_TOKEN@*/)
            .scrollIndicators(/*@START_MENU_TOKEN@*/ .hidden/*@END_MENU_TOKEN@*/, axes: /*@START_MENU_TOKEN@*/[.vertical, .horizontal]/*@END_MENU_TOKEN@*/)
            .scrollContentBackground(/*@START_MENU_TOKEN@*/ .automatic/*@END_MENU_TOKEN@*/)
        }
        .scrollIndicators(/*@START_MENU_TOKEN@*/ .hidden/*@END_MENU_TOKEN@*/, axes: /*@START_MENU_TOKEN@*/[.vertical, .horizontal]/*@END_MENU_TOKEN@*/)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
