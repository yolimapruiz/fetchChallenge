//
//  CardView.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 19/12/24.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var viewModel: RecipesViewModel
    var recipe: Recipe
    
    let  gradient: Gradient = Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)])
    
    var body: some View {
           VStack {
               if let image = viewModel.images[recipe.photoUrl] {
                   Image(uiImage: image)
                       .resizable()
                       .aspectRatio(contentMode: .fill)
                       .overlay(alignment: .bottom) {
                           VStack {
                               Text(recipe.name)
                                   .font(.headline)
                                   .foregroundColor(.white)
                               
                               
                               Text("Cuisine: \(recipe.cuisine)")
                                   .font(.footnote)
                                   .foregroundColor(.white)
                               
                               
                           }
                           .frame(maxWidth: 160)
                           .background(Color.black)
                       }
               } else {
                   ProgressView()
                       .onAppear {
                           Task {
                               await viewModel.fetchImages(for: recipe)
                           }
                       }
               }               
           }
           .frame(width: 160, height: 217, alignment: .top)
           .background(
               LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
           )
           .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
           .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)
           
       }
}

#Preview {
    CardView(viewModel: ContentViewModelMock, recipe: recipeMock)
}
