//
//  FavoritesVIew.swift
//  RecipeLab
//
//  Created by Asadbek Nematov on 5/9/23.
//

import SwiftUI

struct FavoritesView: View {
    @State private var recipes = [
        Recipe(name: "Spaghetti Bolognese",
               description: "A classic Italian pasta dish with rich and flavorful Bolognese sauce.",
               images: ["food1", "food2", "food3"],
               preparation: "Cook the spaghetti according to package instructions. Prepare the Bolognese sauce by cooking ground beef, onion, garlic, tomatoes, and spices. Mix the sauce with the cooked pasta and serve with grated Parmesan cheese."),
        Recipe(name: "Chicken Caesar Salad",
               description: "A fresh and healthy salad with grilled chicken, lettuce, and Caesar dressing.",
               images: ["food2", "food3", "food1"],
               preparation: "Grill the chicken breasts until cooked through. In a large bowl, toss together lettuce, croutons, and Caesar dressing. Top the salad with the grilled chicken and shaved Parmesan cheese."),
        Recipe(name: "Tacos",
               description: "Delicious Mexican tacos filled with seasoned meat, fresh vegetables, and cheese.",
               images: ["food1", "food2", "food3"],
               preparation: "Cook the meat with taco seasoning. Warm the tortillas and fill them with the cooked meat, diced tomatoes, shredded lettuce, and grated cheese. Top with sour cream and salsa."),
        Recipe(name: "Sushi",
               description: "A variety of sushi rolls made with fresh seafood, rice, and vegetables.",
               images: ["food3","food2", "food1"],
               preparation: "Prepare sushi rice by cooking and seasoning it. Slice the seafood and vegetables into thin strips. Place a sheet of nori on a bamboo sushi mat, then spread a layer of sushi rice on the nori. Add the seafood and vegetables in a line, then roll the sushi tightly using the bamboo mat. Cut the roll into bite-sized pieces."),
        Recipe(name: "Cheesecake",
               description: "A creamy and delicious cheesecake with a graham cracker crust.",
               images: ["food2", "food3", "food1"],
               preparation: "Mix together graham cracker crumbs, sugar, and melted butter to form the crust. Press the crust into the bottom of a springform pan. Beat together cream cheese, sugar, and eggs to make the cheesecake filling, then pour it over the crust. Bake the cheesecake at 325°F for 50-60 minutes, then chill before serving.")
    ]
    
    @State private var removingIndices: [Int] = []
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Favorite Recipes")
                    .font(.largeTitle)
                    .padding()
                ForEach(recipes.indices, id: \.self) { index in
                    ZStack(alignment: .topTrailing) {
                        ZStack {
                            Image(recipes[index].images.first ?? "placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                            LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .center, endPoint: .bottom)
                                .opacity(1)
                            Text(recipes[index].name)
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .offset(y: 60)
                            
                            
                            
                            
                        }
                        .frame(height: 200)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding([.top, .horizontal])
                        .frame(maxWidth: .infinity)
                        .offset(x: self.removingIndices.contains(index) ? -UIScreen.main.bounds.width : 0)
                        .animation(self.removingIndices.contains(index) ? .easeIn(duration: 1) : nil, value: recipes)
                        
                        Button(action: {
                            withAnimation {
                                self.removingIndices.append(index)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    self.recipes.remove(at: index)
                                    self.removingIndices.removeAll(where: { $0 == index })
                                }
                            }
                        }) {
                            Image(systemName: "heart.fill")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                        }
                        .padding(30)
                        .offset(x: self.removingIndices.contains(index) ? -UIScreen.main.bounds.width : 0)
                        .animation(self.removingIndices.contains(index) ? .easeIn(duration: 1) : nil, value: recipes)
                    }
                    .padding([.bottom])
                }
            }
        }
    }
}

struct Recipe: Equatable {
    var name: String
    var description: String
    var images: [String]
    var preparation: String
}


struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
