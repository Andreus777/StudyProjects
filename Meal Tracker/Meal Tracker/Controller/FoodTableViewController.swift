//
//  FoodTableViewController.swift
//  Meal Tracker
//
//  Created by Андрей Фокин on 1.10.21.
//

import UIKit

class FoodTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    var meals: [Meal]{
        let breakfast = Meal(name: "breakfast", food: breakFastFood)
        let lunch = Meal(name: "Lunch", food: lunchFood)
        let dinner = Meal(name: "Dinner", food: dinnerFood)
        return [breakfast, lunch, dinner]
    }
    
    let breakFastFood = [Food(name: "Eggs", description: "Boiled eggs"),
                        Food(name: "Coffee", description: "Hot coaffe with milk")]
    
    let lunchFood = [Food(name: "Salad", description: "Fresh salad"),
                     Food(name: "Soup", description: "Hot spicy soup"),
                     Food(name: "Juice", description: "Orange Juice")]
    
    let dinnerFood = [Food(name: "Stake", description: "Tasty stake with blood"),
                      Food(name: "Wine", description: "Red wine 1864"),
                      Food(name: "Fried", description: "Fried potato"),
                      Food(name: "Cake", description: "Chocolate cake")]
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return meals[section].food.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath)
        let meal = meals[indexPath.section].food[indexPath.row]
        cell.textLabel?.text = "\(meal.name)"
        cell.detailTextLabel?.text = "\(meal.description)"
   
        return cell
    }
   
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return meals[section].name
    }

}
