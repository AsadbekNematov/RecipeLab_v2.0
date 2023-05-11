//
//  FavoritesVIew.swift
//  RecipeLab
//
//  Created by Asadbek Nematov on 5/9/23.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        VStack{
            Image(systemName: "heart")
            Text("Favorites View")
        }
        
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
