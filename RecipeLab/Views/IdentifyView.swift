//
//  IdentifyView.swift
//  RecipeLab
//
//  Created by Asadbek Nematov on 5/9/23.
//
import SwiftUI
import Combine

// Ingredient model to match API response
struct IngredientResponse: Decodable {
    let results: [Ingredient]
}
// Recipe model to match API response
struct RecipeResponse: Decodable, Identifiable {
    let id: Int
    let title: String
    let image: String
    let missedIngredients: [Ingredient]
}


struct Ingredient: Identifiable, Decodable {
    let id: Int
    let name: String
    let image: String
}

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            .shadow(color: .gray, radius: 10)
    }
}

struct IdentifyView: View {
    @State private var searchText = ""
    @State private var searchResults = [Ingredient]()
    @State private var ingredientList = [Ingredient]()
    @State private var cancellables = Set<AnyCancellable>()
    @State private var recipeResults = [RecipeResponse]()
    @State private var showingRecipesPopup = false
    @State private var showRecipesView = false



    
    var body: some View {
        NavigationView {
            
            VStack {
                HStack{
                    
                    // Search bar
                    Image(systemName: "magnifyingglass").foregroundColor(.gray)
                    
                    TextField("Search Ingredient", text: $searchText)
                        .onChange(of: searchText, perform: loadIngredients)
                }                    .textFieldStyle(OvalTextFieldStyle())
                
                
                    .padding()
                Spacer()
                
                
                // Display search results
                if !searchResults.isEmpty {
                    Text("Search Results:")
                    List(searchResults) { ingredient in
                        HStack {
                            URLImage(url: "https://spoonacular.com/cdn/ingredients_100x100/\(ingredient.image)")
                            Text(ingredient.name.capitalized)
                                .textInputAutocapitalization(.sentences)
                            
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            ingredientList.append(ingredient)
                            searchResults.removeAll()
                            searchText = ""
                            loadRecipes() // add this line

                        }
                    }
                }
                
                // Display chosen ingredients
                if !ingredientList.isEmpty {
                    Text("Your Ingredients:")
                    List {
                        ForEach(ingredientList.indices, id: \.self) { index in
                            HStack {
                                URLImage(url: "https://spoonacular.com/cdn/ingredients_100x100/\(ingredientList[index].image)")
                                Text(ingredientList[index].name.capitalized)
                                    .textInputAutocapitalization(.sentences)
                                
                                Spacer()
                                Button(action: {
                                    ingredientList.remove(at: index)
                                    
                                }) {
                                    Image(systemName: "trash")
                                }
                                .foregroundColor(.red)
                            }
                        }
                        .onDelete(perform: deleteIngredient)
                    }
                }
              NavigationLink(destination: RecipePopupView(recipes: convertToPopupRecipes(recipeResults))) {
                    HStack{
                        Text("Recipes")
                        Image(systemName: "fork.knife")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .padding(.all, 15.0)
                    .frame(width: 300.0)
                    .foregroundColor(.black)
                    .background(.orange)
                    .cornerRadius(/*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .scenePadding(.horizontal)
                }
            }.sheet(isPresented: $showingRecipesPopup) {
                RecipePopupView(recipes: convertToPopupRecipes(recipeResults))
            }
        }
    }
    func convertToPopupRecipes(_ recipes: [RecipeResponse]) -> [PopupRecipe] {
        recipes.map { PopupRecipe(id: $0.id, title: $0.title, image: $0.image, missedIngredients: $0.missedIngredients) }
    }



    func loadRecipes() {
        let ingredientNames = ingredientList.map { $0.name }.joined(separator: ",+")
        let url = URL(string: "https://api.spoonacular.com/recipes/findByIngredients?ingredients=\(ingredientNames)&number=5&apiKey=e51d14bc19d6447d8c63c52f7a62e9e1")!

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [RecipeResponse].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { response in
                self.recipeResults = response
            })
            .store(in: &cancellables)
        self.showRecipesView = true

    }

    
    // This function should be here, not inside body
    func deleteIngredient(at offsets: IndexSet) {
        withAnimation {
            ingredientList.remove(atOffsets: offsets)
        }
    }
    func loadIngredients(_ searchText: String) {
        guard let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = URL(string: "https://api.spoonacular.com/food/ingredients/search?query=\(encodedSearchText)&number=10&apiKey=e51d14bc19d6447d8c63c52f7a62e9e1")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: IngredientResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { response in
                self.searchResults = response.results
            })
            .store(in: &cancellables)
    }

    
}

struct IdentifyView_Previews: PreviewProvider {
    static var previews: some View {
        IdentifyView()
    }
}



//struct RecipePopupView: View {
//    let recipes: [RecipeResponse]
//
//    var body: some View {
//        NavigationView {
//            List(recipes) { recipe in
//                VStack(alignment: .leading) {
//                    Text(recipe.title)
//                        .font(.headline)
//                    URLImage(url: recipe.image)
//                    Text("Missing Ingredients:")
//                    ForEach(recipe.missedIngredients) { ingredient in
//                        Text(ingredient.name)
//                    }
//                }
//            }
//            .navigationBarTitle("Recipes", displayMode: .inline)
//        }
//    }
//}

