//
//  MasterViewControllerViewModel.swift
//  FetchRewards
//
//  Created by Goutham on 8/20/22.
//

import Foundation

class MasterViewControllerViewModel  {
    
    weak var delegate: TableViewController!
    var numberOfMeals = 0
    var mealData:[Meal] = [Meal(strMeal: "", strMealThumb: "", idMeal: "")]
    
}

extension MasterViewControllerViewModel: modelUpdate  {
    func updateViewModel(data: Data)  {
        let response = try? JSONDecoder().decode(Response.self, from: data)
        guard let response = response else {return}
        numberOfMeals = response.meals.count
        mealData = response.meals
        DispatchQueue.main.async {
            self.delegate.tableViewMain.reloadData()
        }
    }
}
