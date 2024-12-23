//
//  ContentView.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 16/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel: RecipesViewModel
    
    
//    var recipes: [Recipe] {
//        //recipesMock
//        //viewModel.recipeList
//        
//    }
    
//    init(viewModel: RecipesViewModel) {
//        self.viewModel = viewModel
//    }
//    
//    var body: some View {
//        ScrollView {
//        VStack {
//            Text("Recipes")
//                .font(.title)
//                .bold()
//            
//            if recipes.isEmpty {
//                Spacer()
//                Text("No Recipes are available")
//                    .padding(.leading, 4)
//                Spacer()
//            } else {
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 15) {
//                    
//                    ForEach(recipes, id: \.id) {recipe in
//                        CardView(recipe: recipe)
//                    }
//                }
//            }
//            
//            
//        }
//    }
//        .onAppear{
//            
////            //let urls = URLSessionHTTPClient(requestMaker: URLSessionRequestMaker())
//            Task {
//            //    let lista = await dataSource.getRecipesList()
//                await viewModel.getRecipeList()
//
//            }
//            
//            
//        }
//        .refreshable {
//            Task {
//                await viewModel.getRecipeList()
//            }
//        }
//    }
//}

//yol

    init(viewModel: RecipesViewModel) {
        self.viewModel = viewModel
    }
    
    var state: RecipeState {
        viewModel.state
    }
    
    var body: some View {
        ScrollView {
        VStack {
            Text("Recipes")
                .font(.title)
                .bold()
            
            switch state {
            case .loaded(let recipes):
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 15) {
                    
                    ForEach(recipes, id: \.id) {recipe in
                        CardView(recipe: recipe)
                    }
                }
            case .error(let message):
                Spacer()
                Text(message)
                    .padding(.leading, 4)
                Spacer()
                Button(action: {
                    Task {
                        await viewModel.getRecipeList()
                    }
                }) {
                    Text("Retry")
                }
            }
            
        }
    }
        .onAppear{
            
            Task {
           
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

#Preview {
    ContentView(viewModel: ContentViewModelMock)
}
