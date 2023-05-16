//
//  Home.swift
//  CardUI
//
//  Created by paige on 2021/12/09.
//

import SwiftUI

struct Home: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        
        VStack {
            
            Button {
                
            } label: {
                Image("menu")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(
                Text("Discover")
                    .font(.title).fontWeight(.bold)
            )
            .foregroundColor(.black)
            .padding()
            
            // FavoriteRecipes Stack...
            ZStack {
                
                if let recipes = viewModel.displayingRecipes {
                    if recipes.isEmpty {
                        Text("Come back later we can find more matches for you!")
                            .font(.caption)
                            .foregroundColor(.gray)
                    } else {
                        
                        // Displaying Cards
                        // Cards are reversed since its ZStack...
                        // You can use reverse here...
                        // or you can use while fetching recipes...
                        ForEach(recipes.reversed()) { recipe in
                            // Card View...
                            StackCardView(recipe: recipe)
                                .environmentObject(viewModel)
                            
                        }
                        
                    }
                    
                } else {
                    ProgressView()
                }
                
            }
            .padding(.top, 30)
            .padding()
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Action Buttons
            HStack(spacing: 15) {
                Button {
                    
                } label: {
                    Image(systemName: "arrow.uturn.backward")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(.gray)
                        .clipShape(Circle())
                }
                Button {
                    doSwipe(rightSwipe: false)
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 15, weight: .black))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(.blue)
                        .clipShape(Circle())
                }
                Button {
                    
                } label: {
                    Image(systemName: "star.fill")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(.yellow)
                        .clipShape(Circle())
                }
                Button {
                    doSwipe(rightSwipe: true)
                } label: {
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 15, weight: .black))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(.pink)
                        .clipShape(Circle())
                }
                
            } //: HSTACK
            .padding(.bottom)
            .disabled(viewModel.displayingRecipes?.isEmpty ?? true)
            .opacity(viewModel.displayingRecipes?.isEmpty ?? true ? 0.6 : 1)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        
    }
    
    // removing cards when doing Swipe...
    func doSwipe(rightSwipe: Bool = false) {
        guard let first = viewModel.displayingRecipes?.first else {
            return
        }

        // Using Notification to post and receiving in Stack Cards...
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
            "id": first.id,
            "rightSwipe": rightSwipe
        ])
    }
}
struct FavoriteRecipe: Identifiable {
    var id = UUID().uuidString
    var name: String
    var description: String
    var images: [String]
    var preparation: String
}
class HomeViewModel: ObservableObject {
    @Published var fetchedRecipes: [FavoriteRecipe] = []
    @Published var displayingRecipes: [FavoriteRecipe]?
    
    init() {
        // ... initialize your recipes here ...
        fetchedRecipes = [FavoriteRecipe(name: "Spaghetti Bolognese",
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
        displayingRecipes = fetchedRecipes
    }
    
    func getIndex(recipe: FavoriteRecipe) -> Int {
        let index = displayingRecipes?.firstIndex(where: {
            return $0.id == recipe.id
        }) ?? 0
        return index
    }
}

struct StackCardView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    let recipe: FavoriteRecipe
    
    // Gesture Properties...
    @State var offset: CGFloat = 0
    @GestureState var isDragging = false
    
    @State private var currentIndex: Int = 0
    let activeColor: Color = .blue
    let inactiveColor: Color = .gray
    
    @State var endSwipe: Bool = false
    
    var body: some View {
        
        GeometryReader { proxy in
            let size = proxy.size
            let index = CGFloat(viewModel.getIndex(recipe: recipe))
            let topOffset = (index <= 2 ? index : 2) * 15
            
            ZStack {
                Image(recipe.images[currentIndex])
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width - topOffset, height: size.height)
                    .cornerRadius(15)
                    .offset(y: -topOffset).overlay(
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
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
        }
        .offset(x: offset)
        .rotationEffect(.init(degrees: getRotation(angle: 8)))
        // about trim.. https://seons-dev.tistory.com/142
        .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1)) // 뒤에 있는 카드를 못 선택하게 막는다.
        //        .contentShape(Rectangle())
        .gesture(
            DragGesture()
                .updating($isDragging, body: { value, out, _ in
                    out = true
                })
                .onChanged({ value in
                    let translation = value.translation.width
                    offset = (isDragging ? translation : .zero)
                })
                .onEnded({ value in
                    let width = UIScreen.main.bounds.width - 50
                    let translation = value.translation.width
                    let checkingStatus = (translation > 0 ? translation : -translation)
                    withAnimation {
                        if checkingStatus > (width / 2) {
                            // remove card....
                            offset = (translation > 0 ? width : -width) * 2
                            endSwipeActions()
                            
                            if translation > 0 {
                                rightSwipe()
                            } else {
                                leftSwipe()
                            }
                        } else {
                            // reset
                            offset = .zero
                        }
                    }
                })
        )
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"))) { data in
            guard let info = data.userInfo else { return }
            let id = info["id"] as? String ?? ""
            let rightSwipe = info["rightSwipe"] as? Bool ?? false
            let width = UIScreen.main.bounds.width - 50
            
            if recipe.id == id {
                
                // removing card...
                withAnimation {
                    offset = (rightSwipe ? width : -width) * 2
                    endSwipeActions()
                    
                    if rightSwipe {
                        self.rightSwipe()
                    } else {
                        leftSwipe()
                    }
                }
            }
            
        }
        
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
    // Rotation
    private func getRotation(angle: Double) -> Double {
        let rotation = (offset / (UIScreen.main.bounds.width - 50)) * angle
        return rotation
    }
    
    private func endSwipeActions() {
        withAnimation(.none) {
            endSwipe = true
            // after the card is moved away removing the card from array to preserve the memory...
            
            // The delay time based on your animation duration...
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let _ = viewModel.displayingRecipes?.first {
                    _ = withAnimation {
                        viewModel.displayingRecipes?.removeFirst()
                    }
                }
            }
        }
    }
    private func leftSwipe() {
        // DO ACTIONS HERE
        print("Left Swiped")
    }
    
    private func rightSwipe() {
        // DO ACTIONS HERE
        print("Right Swiped")
    }
    
}




struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
