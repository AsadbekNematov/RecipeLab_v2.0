//
//  ExploreView.swift
//  RecipeLab
//
//  Created by Asadbek Nematov on 5/9/23.
//

import SwiftUI

struct ExploreView: View {
    @State private var recipes: [Recipe] = [
        Recipe(name: "Spaghetti Bolognese",
               description: "A classic Italian pasta dish with rich and flavorful Bolognese sauce.",
               images: ["Daler", "JOEY"],
               preparation: "Cook the spaghetti according to package instructions. Prepare the Bolognese sauce by cooking ground beef, onion, garlic, tomatoes, and spices. Mix the sauce with the cooked pasta and serve with grated Parmesan cheese."),
        Recipe(name: "Chicken Caesar Salad",
               description: "A fresh and healthy salad with grilled chicken, lettuce, and Caesar dressing.",
               images: ["Daler", "JOEY"],
               preparation: "Grill the chicken breasts until cooked through. In a large bowl, toss together lettuce, croutons, and Caesar dressing. Top the salad with the grilled chicken and shaved Parmesan cheese."),
        Recipe(name: "Tacos",
               description: "Delicious Mexican tacos filled with seasoned meat, fresh vegetables, and cheese.",
               images: ["Daler", "JOEY"],
               preparation: "Cook the meat with taco seasoning. Warm the tortillas and fill them with the cooked meat, diced tomatoes, shredded lettuce, and grated cheese. Top with sour cream and salsa."),
        Recipe(name: "Sushi",
               description: "A variety of sushi rolls made with fresh seafood, rice, and vegetables.",
               images: ["Daler", "JOEY"],
               preparation: "Prepare sushi rice by cooking and seasoning it. Slice the seafood and vegetables into thin strips. Place a sheet of nori on a bamboo sushi mat, then spread a layer of sushi rice on the nori. Add the seafood and vegetables in a line, then roll the sushi tightly using the bamboo mat. Cut the roll into bite-sized pieces."),
        Recipe(name: "Cheesecake",
               description: "A creamy and delicious cheesecake with a graham cracker crust.",
               images: ["Daler", "JOEY"],
               preparation: "Mix together graham cracker crumbs, sugar, and melted butter to form the crust. Press the crust into the bottom of a springform pan. Beat together cream cheese, sugar, and eggs to make the cheesecake filling, then pour it over the crust. Bake the cheesecake at 325°F for 50-60 minutes, then chill before serving.")
    ]

    @State private var likedRecipes: [Recipe] = []
    @State private var currentIndex = 0
    @State private var previousIndex: Int? = nil

    var body: some View {
        CardStack(recipes: recipes, likedRecipes: $likedRecipes, previousIndex: $previousIndex, showPreparationInfo: showPreparationInfo) {
            RecipeCardView(recipe: recipes[$0])
        }


    }

    private func showPreparationInfo(for recipe: Recipe) {
        // Present an alert or another view with the recipe.preparation info
    }
}

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let images: [String] // Add image names or URLs
    let preparation: String

}

struct RecipeCardView: View {
    @State private var currentImageIndex = 0
    let recipe: Recipe

    var body: some View {
        VStack {
            Image(recipe.images[currentImageIndex]) // Load the image
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .shadow(radius: 10)
                .onTapGesture {
                    currentImageIndex = (currentImageIndex + 1) % recipe.images.count
                }
            Text(recipe.name)
                .font(.title)
                .bold()
            Text(recipe.description)
                .font(.body)
        }
        .padding()
    }
}
struct CardStack<Content: View>: View {
    @State private var currentIndex = 0
    let content: (Int) -> Content

    let recipes: [Recipe]
    let likedRecipes: Binding<[Recipe]>
    let previousIndex: Binding<Int?>
    let showPreparationInfo: (Recipe) -> Void

    init(recipes: [Recipe], likedRecipes: Binding<[Recipe]>, previousIndex: Binding<Int?>, showPreparationInfo: @escaping (Recipe) -> Void, @ViewBuilder content: @escaping (Int) -> Content) {
        self.recipes = recipes
        self.likedRecipes = likedRecipes
        self.previousIndex = previousIndex
        self.showPreparationInfo = showPreparationInfo
        self.content = content
    }

    var body: some View {
        ZStack {
                ForEach(currentIndex..<recipes.count, id: \.self) { index in
                    content(index)
                        .zIndex(Double(index))
                        .offset(dragOffset)
                        .rotationEffect(Angle(degrees: Double(dragOffset.width / 10)))
                        .overlay(
                            GeometryReader { geo in
                                Color.clear
                                    .contentShape(Rectangle())
                                    .gesture(DragGesture(minimumDistance: 10)
                                                .onChanged({ value in
                                                    handleDragChange(value: value, geo: geo)
                                                })
                                                .onEnded({ value in
                                                    handleDrag(value: value, geo: geo)
                                                }))
                            }
                        )
                }
            }
    }

    @State private var dragOffset: CGSize = .zero

    private func handleDragChange(value: DragGesture.Value, geo: GeometryProxy) {
        dragOffset = value.translation
    }

    private func handleDrag(value: DragGesture.Value, geo: GeometryProxy) {
        let width = geo.size.width
        let translationWidth = abs(value.translation.width)
        let translationHeight = abs(value.translation.height)

        if value.translation.width < -width * 0.4 && translationWidth > translationHeight {
            previousIndex.wrappedValue = currentIndex
            currentIndex += 1 // Swiped left
        } else if value.translation.width > width * 0.4 && translationWidth > translationHeight {
            // Swiped right
            likedRecipes.wrappedValue.append(recipes[currentIndex])
            previousIndex.wrappedValue = currentIndex
            currentIndex += 1
        } else if value.translation.height < -width * 0.4 && translationHeight > translationWidth {
            // Swiped up
            showPreparationInfo(recipes[currentIndex])
        } else if value.translation.height > width * 0.4 && translationHeight > translationWidth {
            // Swiped down
            if let previous = previousIndex.wrappedValue {
                currentIndex = previous
                previousIndex.wrappedValue = nil
            }
        }

        withAnimation(.spring()) {
            dragOffset = .zero
        }
    }
}





struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}


/*
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
     VStack {
         VStack {
             // Headlines
             Text("About me")
                 .font(.custom("MontserratRoman-Bold", size: 36))
                 .font(.largeTitle)
                 .fontWeight(.bold)
                 .multilineTextAlignment(.leading)
             // subhead
             Text("Personal Page")
                 .font(.custom("MontserratRoman-Regular", size: 22))
                 .foregroundColor(Color(hue: 0.173, saturation: 0.888, brightness: 0.855))
                 .padding(.bottom, 40.0)
         }
         .padding(.bottom)
         //AboutMe
         VStack {
             Image("about")
                 .resizable()
                 .padding(.bottom, 30)
                 .scaledToFill()
             HStack {
                 Text("Asadbek Nematov")
                     .font(.custom("MontserratRoman-SemiBold", size: 28))
                     .font(.title)
                     .fontWeight(.bold)
                     .multilineTextAlignment(.leading)
                     .padding(.top)
                 Spacer()
             }
             Text("Good day! My name is Asadbek Nematov, and I am 19 years old. I had one year of professional front-end development experience and worked as a freelance front-end developer. I'm currently working on iOS development. You can view my frontend and development projects on my Genepol website, which served as my online portfolio. But now I have changed it into an iOS mobile application.")
                 .font(.custom("MontserratRoman-Regular", size: 16))
                 .padding(.top, 1)
                 .padding(.bottom)
             HStack {
                 Text("Why did I switch from Frontend to iOS?")
                     .font(.custom("MontserratRoman-SemiBold", size: 28))
                     .font(.title)
                     .fontWeight(.bold)
                     .multilineTextAlignment(.leading)
                     .padding(.top, 40)
                 Spacer()
             }
             Text("Beginning my career with front-end web development was an exciting path because it's always evolving and constantly changing. This means one will always have the opportunity to interact with new tools and learn new skills, keeping one engaged in their career. But web apps need an active internet connection to run, whereas mobile apps may work offline. Mobile apps have the advantage of being faster and more efficient.")
                 .font(.custom("MontserratRoman-Regular", size: 16))
                 .padding(.top, 1)
                 .padding(.bottom)
             //Stacks I use
             HStack {
                 Text("Tech stack")
                     .font(.custom("MontserratRoman-SemiBold", size: 28))
                     .font(.title)
                     .fontWeight(.bold)
                     .multilineTextAlignment(.leading)
                     .padding(.top, 40)
                 Spacer()
             }
             Text("Here is my Tech Stack, languages, and frameworks that I use in my projects.")
                 .font(.custom("MontserratRoman-Regular", size: 16))
                 .multilineTextAlignment(.leading)
                 .padding(.top, 1)
                 .padding(.bottom)
             HStack {
                 VStack {
                     Image("swift")
                         .resizable()
                         .scaledToFit()
                     Text("Swift")
                         .font(.custom("MontserratRoman-Regular", size: 14))
                         .font(.caption2)
                 }.padding(.all, 4)
                 VStack {
                     Image("obj-c")
                         .resizable()
                         .scaledToFit()
                     Text("Objective-C")
                         .font(.custom("MontserratRoman-Regular", size: 14))
                         .font(.caption2)
                 }.padding(.all, 4)
                 VStack {
                     Image("HTML")
                         .resizable()
                         .scaledToFit()
                     Text("HTML, CSS")
                         .font(.custom("MontserratRoman-Regular", size: 14))
                         .font(.caption2)
                 }.padding(.all, 4)
             }.padding(.horizontal, 40)
             HStack {
                 VStack {
                     Image("js")
                         .resizable()
                         .scaledToFit()
                     Text("JavaScript")
                         .font(.custom("MontserratRoman-Regular", size: 14))
                         .font(.caption2)
                 }.padding(.all, 4)
                 VStack {
                     Image("bootstrap")
                         .resizable()
                         .scaledToFit()
                     Text("Bootstrap")
                         .font(.custom("MontserratRoman-Regular", size: 14))
                         .font(.caption2)
                 }.padding(.all, 4)
                 VStack {
                     Image("reactjs")
                         .resizable()
                         .scaledToFit()
                     Text("ReactJS")
                         .font(.custom("MontserratRoman-Regular", size: 14))
                         .font(.caption2)
                 }.padding(.all, 4)
             }.padding(.horizontal, 40)
         }
     }.padding(.bottom, 50)
         .padding(.horizontal, 20)
 }
 .preferredColorScheme(/*@START_MENU_TOKEN@*/ .dark/*@END_MENU_TOKEN@*/)
 .scrollIndicators(/*@START_MENU_TOKEN@*/ .hidden/*@END_MENU_TOKEN@*/, axes: /*@START_MENU_TOKEN@*/[.vertical, .horizontal]/*@END_MENU_TOKEN@*/)
 .scrollContentBackground(/*@START_MENU_TOKEN@*/ .automatic/*@END_MENU_TOKEN@*/)*/
