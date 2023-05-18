////
////  RecipePopupView.swift
////  RecipeLab
////
////  Created by Asadbek Nematov on 5/17/23.
////
//import SwiftUI
//
//struct PopupRecipe: Identifiable, Decodable {
//    let id: Int
//    let title: String
//    let image: String
//    let missedIngredients: [Ingredient]
//}
//
//struct RecipePopupView: View {
//    var recipes: [PopupRecipe]
//
//    var body: some View {
//        VStack {
//            Text("Recipes")
//                .font(.largeTitle)
//                .padding()
//            List(recipes) { recipe in
//                VStack(alignment: .leading) {
//                    Text(recipe.title)
//                        .font(.headline)
//                    HStack {
//                        URLImage(url: recipe.image)
//                        ForEach(recipe.missedIngredients) { ingredient in
//                            Text(ingredient.name)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct URLImage: View {
//    @State private var uiImage: UIImage? = nil
//    let url: String
//
//    var body: some View {
//        Group {
//            if let image = self.uiImage {
//                Image(uiImage: image)
//                    .resizable()
//                    .frame(width: 100, height: 100)
//                    .cornerRadius(50)
//            } else {
//                ProgressView()
//            }
//        }.onAppear(perform: loadImage)
//    }
//    func loadImage() {
//        guard let imageURL = URL(string: url) else {
//            return
//        }
//
//        URLSession.shared.dataTask(with: imageURL) { data, response, error in
//            if let data = data, let image = UIImage(data: data) {
//                DispatchQueue.main.async {
//                    self.uiImage = image
//                }
//            }
//        }.resume()
//    }
//}
//
//struct RecipePopupView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipePopupView(recipes: [
//            PopupRecipe(id: 1, title: "Test Recipe", image: "https://via.placeholder.com/150", missedIngredients: [
//                Ingredient(id: 1, name: "Test Ingredient 1", image: "https://via.placeholder.com/150"),
//                Ingredient(id: 2, name: "Test Ingredient 2", image: "https://via.placeholder.com/150")
//            ]),
//            PopupRecipe(id: 2, title: "Another Test Recipe", image: "https://via.placeholder.com/150", missedIngredients: [
//                Ingredient(id: 3, name: "Test Ingredient 3", image: "https://via.placeholder.com/150")
//            ])
//        ])
//    }
//}
//
