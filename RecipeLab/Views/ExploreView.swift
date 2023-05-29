//
//  ExploreView.swift
//  RecipeLab
//
//  Created by Asadbek Nematov on 5/28/23.
//

import SwiftUI
import Combine

struct ExploreView: View {
    
    @ObservedObject var viewModel = ExploreViewModel()
    
    var body: some View {
        
        VStack {
            Text("Explore")
                .font(.title).fontWeight(.bold)
                .foregroundColor(.black)
                .padding()
            
            
            ZStack {
                
                if let recipes = viewModel.displayingRecipes {
                    if recipes.isEmpty {
                        Text("Come back later we can find more matches for you!")
                            .font(.caption)
                            .foregroundColor(.gray)
                    } else {
                        ForEach(recipes.reversed()) { recipe in
                            ExploreCardView(recipe: recipe)
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
            
            HStack(spacing: 15) {
                
                Button {
                    doSwipe(rightSwipe: false)
                } label: {
                    Image(systemName: "xmark")
                }.buttonStyle(CustomButtonStyleMark())
                    .padding(.horizontal, 10)
                    
                Button {
                    
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                }.buttonStyle(CustomButtonStyleArrow())
                
                Button(action: {
                    doSwipe(rightSwipe: true)
                }) {
                    Image(systemName: "heart.fill")
                }
                .buttonStyle(CustomButtonStyleHeart())
                .padding(.horizontal, 10)
                
            }
            .offset(y:-123)
            
            .padding(.bottom)
            .disabled(viewModel.displayingRecipes?.isEmpty ?? true)
            .opacity(viewModel.displayingRecipes?.isEmpty ?? true ? 0.6 : 1)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    func doSwipe(rightSwipe: Bool = false) {
        guard let first = viewModel.displayingRecipes?.first else {
            return
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
            "id": first.id,
            "rightSwipe": rightSwipe
        ])
    }
}

struct ExplorePopupRecipe: Identifiable, Decodable {
    let id: Int
    let title: String
    let image: String
    let missedIngredients: [ExploreIngredient]
}

struct ExploreIngredient: Identifiable, Decodable {
    let id: Int
    let name: String
    let image: String
}

class ExploreViewModel: ObservableObject {
    @Published var fetchedRecipes: [ExplorePopupRecipe] = []
    @Published var displayingRecipes: [ExplorePopupRecipe]?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchRecipes()
    }
    
    func fetchRecipes() {
        let url = URL(string: "https://api.spoonacular.com/recipes/random?number=10&apiKey=e51d14bc19d6447d8c63c52f7a62e9e1")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data}
                    .decode(type: ExploreResponse.self, decoder: JSONDecoder())
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { _ in },
                          receiveValue: { [weak self] response in
                        self?.fetchedRecipes = response.recipes
                        self?.displayingRecipes = response.recipes
                    })
                    .store(in: &cancellables)
            }
    }

        struct ExploreResponse: Decodable {
            let recipes: [ExplorePopupRecipe]
        }

struct ExploreCardView: View {
    let recipe: ExplorePopupRecipe
    var body: some View {
        VStack {
            ZStack {
                URLIngImage(url: recipe.image)
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(10)
                VStack {
                    HStack {
                        Text(recipe.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3, x: 0.0, y: 0.0)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        ForEach(recipe.missedIngredients, id: \.id) { ingredient in
                            Text(ingredient.name)
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 3, x: 0.0, y: 0.0)
                        }
                        Spacer()
                    }
                }
                .padding()
            }
            .padding(.horizontal)
        }
    }
}



        struct ExploreView_Previews: PreviewProvider {
            static var previews: some View {
                ExploreView()
            }
        }

