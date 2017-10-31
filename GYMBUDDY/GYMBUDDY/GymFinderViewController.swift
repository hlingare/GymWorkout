//
//  GymFinderViewController.swift
//  GYMBUDDY
//
//  Created by Dhiman on 10/30/17.
//  Copyright © 2017 Dhiman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class GymFinderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var WorkoutNames = [String]()
    
    var websiteNames = ["http://www.purdue.edu/recwell/","http://places.singleplatform.com/park-west-fitness/menu?ref=google","https://www.faithlafayette.org/gym/centers-and-pool/west-gym","https://www.anytimefitness.com/","http://www.lafayettefamilyymca.org/","http://www.clubnewtone.com/home","https://www.nfpt.com/","https://www.facebook.com/Universal-Fitness-and-Training-114511611940868/","http://www.planetfitness.com/gyms/lafayette-sagamore-pkwy-796","https://www.snapfitness.com/"]
    var FilteredWorkoutNames = [String]()
    var myIndex1 = 0
    var deletedPost = ""
    var websiteString = ""
    
    @IBOutlet weak var TableView1: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return(WorkoutNames.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellcustom")
        var workout = String()
        workout = WorkoutNames[indexPath.row]
        cell.textLabel?.text = workout
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        websiteString = websiteNames[indexPath.row]
        createAlert(title: "Hello!!", message: "Want to go to the gym's website?")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference().child("Local Gyms")
        ref.observe(.value, with: {
            snapshot in
            var WorkoutNames = [String]()
            for workout in snapshot.children {
                WorkoutNames.append((workout as AnyObject).value)
                self.WorkoutNames.append((workout as AnyObject).value)
            }
            self.TableView1.reloadData()
            
        })
        dump(WorkoutNames)
        ref.observeSingleEvent(of: .childAdded, with: { (snapshot) in
            // Get user value
            if let userDict = snapshot.value as? [String:AnyObject] {
                for (key, _) in userDict {
                    let workout:NSObject = userDict[key] as! NSObject
                    
                }
            }
            
        })
    }

    func createAlert (title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print("YES")
            let url12 = self.websiteString
            let url = URL(string: url12)
            UIApplication.shared.open(url!)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print("No")
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
