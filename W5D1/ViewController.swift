//
//  ViewController.swift
//  W5D1
//
//  Created by Erin Luu on 2017-11-28.
//  Copyright © 2017 Erin Luu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  var foodArray = [Food]()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    
//    self.createFood(name: "gourmet pizza", price: 15)
//    self.createFood(name: "perperonni pizza", price: 9)
//    self.createFood(name: "pizza slice", price: 3)
//    self.createFood(name: "pizza special", price: 7)
//    self.createFood(name: "Stake", price: 20)
//    self.createFood(name: "Taco", price: 4)
    
    let query = Food.query()
    query?.whereKey("name", contains: "pizza")
    query?.whereKey("price", lessThan: 10)
    query?.addDescendingOrder("price")
    
    query?.findObjectsInBackground(block: { (results, error) in
        if error == nil {
            guard let foodArray = results as? [Food] else {return}
            self.foodArray = foodArray
            self.tableView.reloadData()
        }
    })
  }
    
   private func createFood(name: String, price: Int) {
        let food = Food(name: name, price: price)
        food.saveInBackground { (succeeded, error) in
            if succeeded {
                print("success")
            } else {
                print("error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
  
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return foodArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    let food = foodArray[indexPath.row]
    cell.textLabel?.text = "\(food.name): $\(food.price).00"
    
    return cell
  }
}

