//
//  Discover.swift
//  RecipeLab
//
//  Created by Asadbek Nematov on 5/18/23.
// 

import SwiftUI

// MARK: - Discover View

struct DiscoverView: View {
    
    @StateObject private var viewModel = ViewModel()
    @State private var isPressed = false

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
            
            // MARK: - DiscoverRecipes Stack...
            ZStack {
                
                if let recipes = viewModel.displayingRecipes {
                    if recipes.isEmpty {
                        Text("Come back later we can find more matches for you!")
                            .font(.caption)
                            .foregroundColor(.gray)
                    } else {
                        // MARK: - Displaying Cards
                        ForEach(recipes.reversed()) { recipe in
                            // Card View...
                            StackCardUIView(recipe: recipe)
                                .environmentObject(viewModel)
                        }
                    }
                } else {
                    ProgressView()
                }
                
            }
                       
                       .padding()
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // MARK: - Action Buttons
            HStack(spacing: 15) {
                
                Button {
                    doSwipe(rightSwipe: false)
                } label: {
                    Image(systemName: "xmark") // replace "redX" with your actual image name
                }.buttonStyle(UICustomButtonStyleMark())
                .padding(.horizontal, 10)
                Button {
                    
                } label: {
                    Image(systemName: "arrow.counterclockwise") // replace "yellowArrow" with your actual image name
                }.buttonStyle(UICustomButtonStyleArrow())
                
                
                Button(action: {
                           doSwipe(rightSwipe: true)
                       }) {
                           Image(systemName: "heart.fill")
                       }
                       .buttonStyle(UICustomButtonStyleHeart())
                       .padding(.horizontal, 10)
                
            } //: HSTACK
            .offset(y:-123)
            
            .padding(.bottom)
            .disabled(viewModel.displayingRecipes?.isEmpty ?? true)
            .opacity(viewModel.displayingRecipes?.isEmpty ?? true ? 0.6 : 1)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        
    }
    
    // MARK: - removing cards when doing Swipe...
    func doSwipe(rightSwipe: Bool = false) {
        guard let first = viewModel.displayingRecipes?.first else {
            return
        }
        
        // MARK: - Using Notification to post and receiving in Stack Cards...
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
            "id": first.id,
            "rightSwipe": rightSwipe
        ])
    }
}

//MARK: - Trigger design of action buttons
struct UICustomButtonStyleHeart: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 30))
            .foregroundColor(configuration.isPressed ? .white : .green)
            .padding()
            .background(configuration.isPressed ? Circle().fill(Color.green) : Circle().fill(Color.clear))
            .overlay(
                Circle()
                    .stroke(Color.green, lineWidth: 1)
            )
    }
}
struct UICustomButtonStyleArrow: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 25, weight: .black))
            .foregroundColor(configuration.isPressed ? .white : .yellow)
            .padding()
            .background(configuration.isPressed ? Circle().fill(Color.yellow) : Circle().fill(Color.clear))
            .overlay(
                Circle()
                    .stroke(Color.yellow, lineWidth: 1)
            )
    }
}
struct UICustomButtonStyleMark: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 30, weight: .black))
            .foregroundColor(configuration.isPressed ? .white : .red)
            .padding()
            .background(configuration.isPressed ? Circle().fill(Color.red) : Circle().fill(Color.clear))
            .overlay(
                Circle()
                    .stroke(Color.red, lineWidth: 1)
            )
    }
}


//MARK: - End of Trigger design of action buttons

struct DiscoverRecipe: Identifiable {
    var id = UUID().uuidString
    var name: String
    var description: String
    var images: [String]
    var preparation: String
}
class ViewModel: ObservableObject {
    @Published var fetchedRecipes: [DiscoverRecipe] = []
    @Published var displayingRecipes: [DiscoverRecipe]?
    
    
    init() {
        // MARK: - DiscoverRecipe
        
        fetchedRecipes = [DiscoverRecipe(name: "Spaghetti Bolognese",
                                         description: "A classic Italian pasta dish with rich and flavorful Bolognese sauce.",
                                         images: ["food1", "food2", "food3"],
                                         preparation: "Cook the spaghetti according to package instructions. Prepare the Bolognese sauce by cooking ground beef, onion, garlic, tomatoes, and spices. Mix the sauce with the cooked pasta and serve with grated Parmesan cheese."),
                          DiscoverRecipe(name: "Chicken Caesar Salad",
                                         description: "A fresh and healthy salad with grilled chicken, lettuce, and Caesar dressing.",
                                         images: ["food2", "food3", "food1"],
                                         preparation: "Grill the chicken breasts until cooked through. In a large bowl, toss together lettuce, croutons, and Caesar dressing. Top the salad with the grilled chicken and shaved Parmesan cheese."),
                          DiscoverRecipe(name: "Tacos",
                                         description: "Delicious Mexican tacos filled with seasoned meat, fresh vegetables, and cheese.",
                                         images: ["food1", "food2", "food3"],
                                         preparation: "Cook the meat with taco seasoning. Warm the tortillas and fill them with the cooked meat, diced tomatoes, shredded lettuce, and grated cheese. Top with sour cream and salsa."),
                          DiscoverRecipe(name: "Sushi",
                                         description: "A variety of sushi rolls made with fresh seafood, rice, and vegetables.",
                                         images: ["food3","food2", "food1"],
                                         preparation: "Prepare sushi rice by cooking and seasoning it. Slice the seafood and vegetables into thin strips. Place a sheet of nori on a bamboo sushi mat, then spread a layer of sushi rice on the nori. Add the seafood and vegetables in a line, then roll the sushi tightly using the bamboo mat. Cut the roll into bite-sized pieces."),
                          DiscoverRecipe(name: "Cheesecake",
                                         description: "A creamy and delicious cheesecake with a graham cracker crust.",
                                         images: ["food2", "food3", "food1"],
                                         preparation: "Mix together graham cracker crumbs, sugar, and melted butter to form the crust. Press the crust into the bottom of a springform pan. Beat together cream cheese, sugar, and eggs to make the cheesecake filling, then pour it over the crust. Bake the cheesecake at 325°F for 50-60 minutes, then chill before serving.")
                          
        ]
        displayingRecipes = fetchedRecipes
    }
    
    func getIndex(recipe: DiscoverRecipe) -> Int {
        let index = displayingRecipes?.firstIndex(where: {
            return $0.id == recipe.id
        }) ?? 0
        return index
    }
}

struct StackCardUIView: View {
    
    @EnvironmentObject private var viewModel: ViewModel
    let recipe: DiscoverRecipe
    
    // MARK: - Gesture Properties...
    @State var offset: CGFloat = 0
    @GestureState var isDragging = false
    
    @State private var currentIndex: Int = 0
    let activeColor: Color = .blue
    let inactiveColor: Color = .gray
    
    @State var endSwipe: Bool = false
    
    var body: some View {
        
        GeometryReader { proxy in
            let size = proxy.size
            ZStack {
                HStack{
                    Image(recipe.images[currentIndex])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(1.5)]),
                                startPoint: .center,
                                endPoint: .bottom)
                        )
                }
                .cornerRadius(15)
                .padding(.horizontal, 10)
                
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
                    }.offset(y:140)
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
            .frame(width: size.width, height: size.height)
            
            
            
        }
        
        .offset(x: offset, y: -20)
        .rotationEffect(.init(degrees: getRotation(angle: 8)))
        .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
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




struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
