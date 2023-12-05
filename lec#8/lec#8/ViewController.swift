//
//  ViewController.swift
//  lec#8


import UIKit
import CoreData

class ViewController: UIViewController {

    static let applicationDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = applicationDelegate.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add()
        getUser()
    }
    
    func userDefaultsGetData() {
        
    }

    func getUser() {
        let request: NSFetchRequest<User> = User.fetchRequest()
           request.returnsObjectsAsFaults = false
           
           do {
               let users = try context.fetch(request)
               for user in users {
                   print("User Name: \(user.name ?? "Unknown")")
                   if let orders = user.order as? Set<Order> {
                       for order in orders {
                           print("  Order Name: \(order.name ?? "Unknown")")
                       }
                   }
               }
           } catch {
               print("Error fetching users: \(error)")
           }
    }
    
    
    
    func add() {
        let entity1 = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        let newUser1 = NSManagedObject(entity: entity1!, insertInto: context)
        newUser1.setValue("Yulia", forKey: "name")
        newUser1.setValue("1", forKey: "id")
        
        ViewController.applicationDelegate.saveContext()
        
        let newUser2 = NSManagedObject(entity: entity1!, insertInto: context)
        newUser2.setValue("Yulia2", forKey: "name")
        newUser2.setValue("2", forKey: "id")
        
        
        ViewController.applicationDelegate.saveContext()
        
        let entity2 = NSEntityDescription.entity(forEntityName: "Order", in: context)
        
        let newOrder1 = NSManagedObject(entity: entity2!, insertInto: context)
        newOrder1.setValue("order1", forKey: "name")
        newOrder1.setValue("1", forKey: "id")

        ViewController.applicationDelegate.saveContext()
        
        let newOrder2 = NSManagedObject(entity: entity1!, insertInto: context)
        newOrder2.setValue("order2", forKey: "name")
        newOrder2.setValue("2", forKey: "id")
        
        newUser1.mutableSetValue(forKey: "orders").add(newOrder1)
        newUser2.mutableSetValue(forKey: "orders").add(newOrder2)
        ViewController.applicationDelegate.saveContext()
        print("added Orders")
    }
}

