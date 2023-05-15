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
    
    var body: some View {
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
        }
    }
    
    // This function should be here, not inside body
    func deleteIngredient(at offsets: IndexSet) {
        withAnimation {
            ingredientList.remove(atOffsets: offsets)
        }
    }
    func loadIngredients(_ searchText: String) {
        let url = URL(string: "https://api.spoonaculaar.com/food/ingredients/search?query=\(searchText)&number=10&apiKey=e51d14bc19d6447d8c63c52f7a62e9e1")!
        
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

struct URLImage: View {
    @State private var uiImage: UIImage? = nil
    let url: String
    
    var body: some View {
        Group {
            if let image = self.uiImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(50)
            } else {
                ProgressView()
            }
        }.onAppear(perform: loadImage)
    }
    
    func loadImage() {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.uiImage = image
                }
            }
        }.resume()
    }
}

