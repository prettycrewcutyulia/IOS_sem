import UIKit

struct Task: Codable {
    var id: Int
    var name: String
}

struct PatchedTask: Codable {
    var name: String
}

class ViewController: UIViewController {
    
    let baseURL = "http://localhost:8080" // Need to specify http:// for baseURL
    
    @IBAction func getitems(_ sender: Any) {
        let url = URL(string: "\(baseURL)/get-items")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Task].self, from: data)
                print(decodedData)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        task.resume() // Start the URLSession data task
    }
    
    @IBAction func getItemByID(_ sender: Any) {
        // Construct the URL with query parameters
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        let id = 1
           // Construct the URL with query parameters
           guard var urlComponents = URLComponents(string: "http://localhost:8080/get-item-by-id") else {
               print("Invalid URL")
               return
           }
           urlComponents.queryItems = [URLQueryItem(name: "id", value: "\(id)")]

           guard let url = urlComponents.url else {
               print("Invalid URL")
               return
           }

           var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
           request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
           
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("Error: \(error)")
                   return
               }
               
               guard let data = data else {
                   print("No data received")
                   return
               }
               
               if let taskName = String(data: data, encoding: .utf8) {
                   print("Task Name:", taskName)
               } else {
                   print("Couldn't convert data to string")
               }
           }
           
           task.resume() // Start the URLSession data task
    }


    
        @IBAction func postItemByName(_ sender: Any) {
            let newTaskName = "New Task" // Replace this with the desired task name
            
            let url = URL(string: "\(baseURL)/post-item-by-name")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let newTask = Task(id: 0, name: newTaskName)
            
            do {
                let jsonData = try JSONEncoder().encode(newTask)
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error: \(error)")
                        return
                    }
                    
                    guard let data = data else {
                        print("No data received")
                        return
                    }
                    
                    do {
                        let createdTask = try JSONDecoder().decode(Task.self, from: data)
                        print("Created Task:", createdTask)
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
                
                task.resume() // Start the URLSession data task
            } catch {
                print("Error encoding JSON: \(error)")
            }
        }
    
    
    @IBAction func updateItemName(_ sender: Any) {
            let idToUpdate = 1 // Replace with the desired ID to update
            let updatedName = "Updated Task Name" // Replace with the new name
            
            let url = URL(string: "\(baseURL)/put-item-name-by-id")! // No need to include ID in URL for PUT request
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            
            // Create a dictionary with id and name
            let updatedData: [String: Any] = ["id": idToUpdate, "name": updatedName]
            
            // Convert the dictionary to JSON data
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: updatedData, options: [])
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error: \(error)")
                        return
                    }
                    
                    guard let data = data else {
                        print("No data received")
                        return
                    }
                    
                    // Handle the response if needed
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Response: \(responseString)")
                    }
                }
                
                task.resume() // Start the URLSession data task
            } catch {
                print("Error encoding JSON: \(error)")
            }
        }
    
    @IBAction func deleteItemByID(_ sender: Any) {
            let idToDelete = 1 // Replace with the ID you want to delete
            
            let url = URL(string: "\(baseURL)/delete-item-by-id/\(idToDelete)")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                // Handle the response if needed
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response: \(responseString)")
                }
            }
            
            task.resume() // Start the URLSession data task
        }
    
    @IBAction func deleteAllItems(_ sender: Any) {
           let url = URL(string: "\(baseURL)/delete-items")!
           
           var request = URLRequest(url: url)
           request.httpMethod = "DELETE"
           
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("Error: \(error)")
                   return
               }
               
               guard let data = data else {
                   print("No data received")
                   return
               }
               
               // Handle the response if needed
               if let responseString = String(data: data, encoding: .utf8) {
                   print("Response: \(responseString)")
               }
           }
           
           task.resume() // Start the URLSession data task
       }
    
    @IBAction func patchItemNameByID(_ sender: Any) {
            let idToUpdate = 1 // Replace with the ID you want to update
            let updatedName = "Updated Partial Name" // Replace with the new partial name
            
            let url = URL(string: "\(baseURL)/patch-item-name-by-id/\(idToUpdate)")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            
            // Create an instance of PatchedTask with the updated partial name
            let patchedTask = PatchedTask(name: updatedName)
            
            // Convert the PatchedTask instance to JSON data
            do {
                let jsonData = try JSONEncoder().encode(patchedTask)
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error: \(error)")
                        return
                    }
                    
                    guard let data = data else {
                        print("No data received")
                        return
                    }
                    
                    // Handle the response if needed
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Response: \(responseString)")
                    }
                }
                
                task.resume() // Start the URLSession data task
            } catch {
                print("Error encoding JSON: \(error)")
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
 
