//
//  ExploreView.swift
//  RecipeLab
//
//  Created by Asadbek Nematov on 5/9/23.
//



import SwiftUI

class ImageIndex: ObservableObject {
    @Published var value: Int = 0
}



struct ExploreView: View {
    @State private var recipes: [Recipe] = [
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
    
    @State private var likedRecipes: [Recipe] = []
    @State private var currentIndex = 0
    @State private var previousIndex: Int? = nil
    
    var body: some View {
        CardStack(recipes: recipes, likedRecipes: $likedRecipes, previousIndex: $previousIndex, showPreparationInfo: showPreparationInfo) { index in
            RecipeCardView(imageIndex: .constant(index), recipe: recipes[index])
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
    @Binding var imageIndex: Int
    let recipe: Recipe
    @State private var currentImageIndex = 0
    let activeColor: Color = .blue
    let inactiveColor: Color = .gray

    var body: some View {
        VStack {
            ImageGalleryView(images: recipe.images, currentIndex: $currentImageIndex)
                .frame(width: 380, height: 500, alignment: .center)
                .cornerRadius(10)
                .padding(.horizontal)
            
            VStack {
                indicatorBar
                    .padding(.bottom, 10)
            }.offset(y: 0)
            
            Text(recipe.name)
                .font(.title)
                .bold()
            Text(recipe.description)
                .font(.body)
        }
        .padding()
    }
    private var indicatorBar: some View {
            HStack(spacing: 8) {
                ForEach(0..<recipe.images.count, id: \.self) { index in
                    Circle()
                        .fill(index == imageIndex ? activeColor : inactiveColor)
                        .frame(width: 8, height: 8)
                        .animation(.easeInOut(duration: 0.3), value: imageIndex)
                }
            }
        }
    }


struct ImageGalleryView: View {
    let images: [String]
    @Binding var currentIndex: Int
    
    var body: some View {
        ZStack {
            Image(images[currentIndex])
                .resizable()
                .scaledToFit()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                .clipped()
            
            HStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        } else {
                            currentIndex = images.count - 1
                        }
                    }
                
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if currentIndex < images.count - 1 {
                            currentIndex += 1
                        } else {
                            currentIndex = 0
                        }
                    }
            }
        }
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
            ForEach((currentIndex..<recipes.count).reversed(), id: \.self) { index in
                content(index)
                    .zIndex(Double(recipes.count - index))
                    .offset(index == currentIndex ? dragOffset : .zero)
                    .rotationEffect(Angle(degrees: index == currentIndex ? Double(dragOffset.width / 10) : 0))
                    .overlay(
                        GeometryReader { geo in
                            if index == currentIndex {
                                Color.clear
                                    .contentShape(Rectangle())
                                    .highPriorityGesture(
                                        DragGesture(minimumDistance: 10)
                                            .onChanged({ value in
                                                handleDragChange(value: value, geo: geo)
                                            })
                                            .onEnded({ value in
                                                handleDrag(value: value, geo: geo)
                                            })
                                    )
                                    .simultaneousGesture(
                                        TapGesture()
                                            .onEnded({
                                                handleImageGalleryTap(geo: geo)
                                            })
                                    )
                            }
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
            withAnimation(.spring()) {
                dragOffset = CGSize(width: -width, height: 0)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring()) {
                    dragOffset = .zero
                }
                previousIndex.wrappedValue = currentIndex
                currentIndex += 1
                print("left")
            }
        } else if value.translation.width > width * 0.4 && translationWidth > translationHeight {
            withAnimation(.spring()) {
                dragOffset = CGSize(width: width, height: 0)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring()) {
                    dragOffset = .zero
                }
                likedRecipes.wrappedValue.append(recipes[currentIndex])
                previousIndex.wrappedValue = currentIndex
                currentIndex += 1
            }
        } else if value.translation.height < -width * 0.4 && translationHeight > translationWidth {
            // Swiped up
            showPreparationInfo(recipes[currentIndex])
        } else if value.translation.height > width * 0.4 && translationHeight > translationWidth {
            // Swiped down
            if let previous = previousIndex.wrappedValue {
                currentIndex = previous
                previousIndex.wrappedValue = nil
            }
        } else {
            withAnimation(.spring()) {
                dragOffset = .zero
            }
        }
    }
    
    private func handleImageGalleryTap(geo: GeometryProxy) {
        let halfWidth = geo.size.width / 2
        let location = geo.frame(in: .global).origin.x
        
        if location < halfWidth {
            if currentIndex > 0 {
                currentIndex -= 1
            } else {
                currentIndex = recipes[currentIndex].images.count - 1
            }
        } else {
            if currentIndex < recipes[currentIndex].images.count - 1 {
                currentIndex += 1
            } else {
                currentIndex = 0
            }
        }
    }
}



struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
