//
//  ViewController.swift
//  CoreDataExample
//
//  Created by apple on 10/01/19.
//  Copyright © 2019 iOSProofs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var schoolsListView: UITableView!
    var schools: [School] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSchools()
    }
    
    func fetchSchools() {
        schools = CoreDataManager.shared.fetch()
        print(schools)
        schoolsListView.reloadData()
    }

    @IBAction func addSchool(_ sender: Any) {
        let newSchool = School(context: CoreDataManager.shared.context)
        newSchool.name = "Narayana"
        newSchool.address = "Hyderabad"
        newSchool.established = Date()
        CoreDataManager.shared.save()
        fetchSchools()        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolCell")
        let aSchool = schools[indexPath.row]
        cell?.textLabel?.text = aSchool.name
        cell?.detailTextLabel?.text = aSchool.address
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let schoolToBeDelete = schools[indexPath.row]
            CoreDataManager.shared.deleteSchool(aSchool: schoolToBeDelete)
            fetchSchools()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let aSchool = schools[indexPath.row]
        aSchool.name = "Chaithnya"
        aSchool.address = "Banglore"
        CoreDataManager.shared.save()
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
}

