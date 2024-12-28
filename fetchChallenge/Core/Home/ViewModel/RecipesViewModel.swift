//
//  RecipesViewModel.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 19/12/24.
//

import Foundation
import UIKit

enum RecipeState {
    case loaded([Recipe])
    case error(String)
}

@MainActor
class RecipesViewModel: ObservableObject {
    private let repository: RecipeListRepositoryType
    private let imageRepository: RecipeImageRepositoryType
    
    @Published var state: RecipeState = .loaded([])
    @Published var images: [String: UIImage] = [:]
    
    init(repository: RecipeListRepositoryType, imageRepository: RecipeImageRepositoryType) {
        self.repository = repository
        self.imageRepository = imageRepository
    }
    
    func getRecipeList() async {
        
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
                print("DEGUG: \(error)")
            }
        }
    }
    
    
    func fetchImages(for recipe: Recipe) async {
        let recipeImageUrl = recipe.photoUrl
        
        
        let result = await imageRepository.getImage(url: URL(string: recipeImageUrl))
        
        switch result {
            
        case .success(let imageData):
            let image = UIImage(data: imageData)
            
            self.images[recipe.photoUrl] = image
        case .failure(_):
            print(" Error fetching image")
        }
    }
    
    
}
