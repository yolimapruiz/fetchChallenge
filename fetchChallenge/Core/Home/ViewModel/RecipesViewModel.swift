//
//  RecipesViewModel.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 19/12/24.
//

import Foundation

enum RecipeState {
    case loaded([Recipe])
    case error(String)
}

class RecipesViewModel: ObservableObject {
    private let repository: RecipeListRepositoryType
    
    init(repository: RecipeListRepositoryType) {
        self.repository = repository
    }
    
    //@Published var recipeList: [Recipe] = []
    @Published var state: RecipeState = .loaded([])
   
    @MainActor
    func getRecipeList() async {
        //        Task{
        //            let result = await repository.getRecipeList()
        //            switch result {
        //
        //            case .success(let recipeList):
        //                 self.recipeList = recipeList
        //            case .failure(let error):
        //
        //                print(error.localizedDescription)
        //            }
        //        }
        
        Task{
            let result = await repository.getRecipeList()
            switch result {
                
            case .success(let recipeList):
            
                self.state = .loaded(recipeList)
                
            case .failure(let error):
                
                switch error {
                case .emptyData:
                    self.state = .error(error.localizedDescription)
                case .decodingError:
                    self.state = .error("We couldn't get the recipes.Try again")
                default:
                    self.state = .error("Ocurrio algo inesperado")
                }
                
                
            }
        
            
        }
        
    }
    }




