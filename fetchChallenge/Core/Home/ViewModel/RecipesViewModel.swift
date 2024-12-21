//
//  RecipesViewModel.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 19/12/24.
//

import Foundation

class RecipesViewModel: ObservableObject {
    private let repository: RecipeListRepositoryType
    
    init(repository: RecipeListRepositoryType) {
        self.repository = repository
    }
    
    @Published var recipeList: [Recipe] = []
    
   
    @MainActor
    func getRecipeList() async {
        Task{
            let result = await repository.getRecipeList()
            switch result {
            
            case .success(let recipeList):
                 self.recipeList = recipeList
            case .failure(_):
                print("Error fetching Recipes")
            }
        }
           
    }
}



