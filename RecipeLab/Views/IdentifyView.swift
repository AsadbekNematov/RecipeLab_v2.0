//
//  IdentifyView.swift
//  RecipeLab
//
//  Created by Asadbek Nematov on 5/9/23.
//

import SwiftUI

struct IdentifyView: View {
    
    var body: some View {
        HStack{
            
            Text("IdentifyView")
            Image(systemName: "camera.fill")
        }
    }
}

struct IdentifyView_Previews: PreviewProvider {
    static var previews: some View {
        IdentifyView()
    }
}
