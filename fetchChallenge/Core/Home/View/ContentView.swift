//
//  ContentView.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 16/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel: RecipesViewModel
    
    
    var recipes: [Recipe] {
        //recipesMock
        viewModel.recipeList
    }
    
    init(viewModel: RecipesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
        VStack {
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 15) {
                
                ForEach(recipes, id: \.id) {recipe in
                    CardView(recipe: recipe)
                }
            }
            
        }
    }
        .onAppear{
            
//            //let urls = URLSessionHTTPClient(requestMaker: URLSessionRequestMaker())
            Task {
            //    let lista = await dataSource.getRecipesList()
                await viewModel.getRecipeList()

            }
            
            
        }
        .refreshable {
            Task {
                await viewModel.getRecipeList()
            }
        }
    }
}

//yol



#Preview {
    ContentView(viewModel: ContentViewModelMock)
}
