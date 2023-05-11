//
//  ExploreView.swift
//  RecipeLab
//
//  Created by Asadbek Nematov on 5/9/23.
//


import SwiftUI

struct ExploreView: View {
    
    @State private var favoriteRecipes: [FavoriteRecipe] = getFavoriteRecipes()

    var body: some View {
        VStack {
            Text("Explore all recipes")
                .font(.title)
            Spacer()

            // Create the card stack view
            CardStackView<RecipeCardView>(cards: createCardViews(), cardAction: cardAction, loopCards: true)
                .offset(y:-15)
            // Add action buttons
                       HStack {
                           Button(action: {
                               // Action for Nope/Left (Red X)
                               print("Nope/Left action performed")
                           }) {
                               Image(systemName: "xmark") // replace "redX" with your actual image name
                                   .font(.system(size: 30)) // size of the
                                   .foregroundColor(.red) // color of the
                                   .padding() // padding around the
                                   .overlay( // border around the
                                       Circle()
                                           .stroke(Color.red, lineWidth: 1)
                                   )
                           }.padding(.horizontal, 10)
                           Button(action: {
                               // Action for Rewind (Yellow arrow)
                               print("Rewind action performed")
                           }) {
                               Image(systemName: "arrow.counterclockwise") // replace "yellowArrow" with your actual image name
                                   .font(.system(size: 15)) // size of the
                                   .foregroundColor(.yellow) // color of the
                                   .padding() // padding around the
                                   .overlay( // border around the
                                       Circle()
                                           .stroke(Color.yellow, lineWidth: 1)
                                   )
                           }
                           Button(action: {
                               // Action for Like/Right (Green heart)
                               print("Like/Right action performed")
                           }) {
                               Image(systemName: "heart.fill") // replace "greenHeart" with your actual image name
                                   .font(.system(size: 30)) // size of the
                                   .foregroundColor(.green) // color of the
                                   .padding() // padding around the
                                   .overlay( // border around the
                                       Circle()
                                           .stroke(Color.green, lineWidth: 1)
                                   )
                           }.padding(.horizontal, 10)
                       }
                      // .padding(.top, 20) // add some padding at the top of the action buttons

            Spacer()
        }
        .padding()
    }
    
    // Create card views from the favorite recipes
    private func createCardViews() -> [CardSwipeView<RecipeCardView>] {
        return favoriteRecipes.map { recipe in
            CardSwipeView(onCardRemoved: {
                print("\(recipe.name) removed") // Perform any action when the card is removed
            }, onCardAdded: {
                print("\(recipe.name) added") // Perform any action when the card is added
            }) {
                RecipeCardView(recipe: recipe) // Your custom view for each recipe card
            }
        }
    }
    
    // Action to perform when a card is swiped away
    private func cardAction() {
        print("Card swiped away")
    }
}

struct RecipeCardView: View {
    var recipe: FavoriteRecipe
    @State private var currentIndex: Int = 0
    let activeColor: Color = .blue
    let inactiveColor: Color = .gray

    var body: some View {
        ZStack {
            Image(recipe.images[currentIndex])
                .resizable()
                .aspectRatio(contentMode: .fit) .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(1.5)]),
                        startPoint: .center,
                        endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                )
            
            VStack {
                indicatorBar
                    .padding(.bottom, 10)
                    .offset(y:-210)
                VStack{
                    
                    Text(recipe.name)
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                    Text(recipe.description)
                        .font(.body)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }.offset(y:160)
                    .padding(.horizontal, 20)
            }
            
            HStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        } else {
                            currentIndex = recipe.images.count - 1
                        }
                    }

                Rectangle()
                    .fill(Color.clear)
                    .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if currentIndex < recipe.images.count - 1 {
                            currentIndex += 1
                        } else {
                            currentIndex = 0
                        }
                    }
            }
        }
        .padding(.horizontal)
        .frame(width: 380,height: 600)
        .background(Color.white)
        .cornerRadius(10)
        Spacer()
    }

    private var indicatorBar: some View {
        HStack(spacing: 8) {
            ForEach(recipe.images.indices, id: \.self) { index in
                Circle()
                    .fill(index == currentIndex ? activeColor : inactiveColor)
                    .frame(width: 8, height: 8)
                    .animation(.easeInOut(duration: 0.3), value: currentIndex)
            }
        }
    }
}

struct FavoriteRecipe: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let images: [String]
    let preparation: String
}

func getFavoriteRecipes() -> [FavoriteRecipe] {
    return [
        FavoriteRecipe(name: "Spaghetti Bolognese",
               description: "A classic Italian pasta dish with rich and flavorful Bolognese sauce.",
               images: ["food1", "food2", "food3"],
               preparation: "Cook the spaghetti according to package instructions. Prepare the Bolognese sauce by cooking ground beef, onion, garlic, tomatoes, and spices. Mix the sauce with the cooked pasta and serve with grated Parmesan cheese."),
        FavoriteRecipe(name: "Chicken Caesar Salad",
               description: "A fresh and healthy salad with grilled chicken, lettuce, and Caesar dressing.",
               images: ["food2", "food3", "food1"],
               preparation: "Grill the chicken breasts until cooked through. In a large bowl, toss together lettuce, croutons, and Caesar dressing. Top the salad with the grilled chicken and shaved Parmesan cheese."),
        FavoriteRecipe(name: "Tacos",
               description: "Delicious Mexican tacos filled with seasoned meat, fresh vegetables, and cheese.",
               images: ["food1", "food2", "food3"],
               preparation: "Cook the meat with taco seasoning. Warm the tortillas and fill them with the cooked meat, diced tomatoes, shredded lettuce, and grated cheese. Top with sour cream and salsa."),
        FavoriteRecipe(name: "Sushi",
               description: "A variety of sushi rolls made with fresh seafood, rice, and vegetables.",
               images: ["food3","food2", "food1"],
               preparation: "Prepare sushi rice by cooking and seasoning it. Slice the seafood and vegetables into thin strips. Place a sheet of nori on a bamboo sushi mat, then spread a layer of sushi rice on the nori. Add the seafood and vegetables in a line, then roll the sushi tightly using the bamboo mat. Cut the roll into bite-sized pieces."),
        FavoriteRecipe(name: "Cheesecake",
               description: "A creamy and delicious cheesecake with a graham cracker crust.",
               images: ["food2", "food3", "food1"],
               preparation: "Mix together graham cracker crumbs, sugar, and melted butter to form the crust. Press the crust into the bottom of a springform pan. Beat together cream cheese, sugar, and eggs to make the cheesecake filling, then pour it over the crust. Bake the cheesecake at 325°F for 50-60 minutes, then chill before serving.")
    ]
}
struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
