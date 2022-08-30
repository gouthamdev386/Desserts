//
//  DetailViewControllerViewModel.swift
//  FetchRewards
//
//  Created by Goutham on 8/20/22.
//

import Foundation

class DetailViewControllerViewModel {
    
    var delegate: DetailViewController!
    
    var ingredients:[String] = []
    
    var nonEmptyIngredients = 0
    
    var mealId: String = ""
    
    var recipeText: String = ""

}

extension DetailViewControllerViewModel: modelUpdate
{
    func updateViewModel(data: Data)  {
        let response = try? JSONDecoder().decode(mealResponse.self, from: data)
        guard let response = response else {return}
        let ingredients = response.meals[0]
        DispatchQueue.main.async {
            
            guard let mealNameOptional = ingredients["strMeal"], let mealNameUnwrapped = mealNameOptional else {return}
            self.delegate.title = mealNameUnwrapped + " Recipe"
            
            guard let strInstructionsOptional = ingredients["strInstructions"], let strInstructionsUnwrapped = strInstructionsOptional else {return}
            self.recipeText = strInstructionsUnwrapped
            
            for i in 1...20 {
                
                guard let measure = ingredients["strMeasure" + String(i)], let ingredient = ingredients["strIngredient" +  String(i)] else
                {return
                }
                                     
                
                self.ingredients.append((measure ?? "") + " " + (ingredient ?? ""))
                //Deal with empty values
                if (measure != "" ) && (ingredient != "") {
                    self.nonEmptyIngredients = self.nonEmptyIngredients + 1
                }
            }
            self.delegate.ingredientsTableView.reloadData()
            self.delegate.recipeText.text = self.recipeText
        }
        
    }
}
