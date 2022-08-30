//
//  ViewController.swift
//  FetchRewards
//
//  Created by goutham thota on 8/15/22.
//

import UIKit
import SDWebImage

class TableViewController: UIViewController {
    
    var tableViewMain = UITableView()
    
    var viewModel = MasterViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Desserts"
        self.view.backgroundColor = .white
        
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        self.view.addSubview(tableViewMain)
        
        viewModel.delegate = self
        
        tableViewMain.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableViewMain.leadingAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.leadingAnchor),
            tableViewMain.trailingAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.trailingAnchor),
            tableViewMain.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor),
            tableViewMain.bottomAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkLayer(delegate: self.viewModel as modelUpdate).call(url: Constants.masterUrl)
        
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMeals
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.mealData[indexPath.row].strMeal
        cell.textLabel?.font.withSize(10)
        
        let url = viewModel.mealData[indexPath.row].strMealThumb
        cell.imageView?.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "imagename"))
        //caching images using SDWebImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //create detail vc
        //push from nav conrtroller
        
        let detailVC = DetailViewController()
        detailVC.mealId =  viewModel.mealData[indexPath.row].idMeal
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    
    
}
