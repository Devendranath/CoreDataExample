//
//  StudentsListViewController.swift
//  CoreDataExample
//
//  Created by apple on 11/01/19.
//  Copyright © 2019 iOSProofs. All rights reserved.
//

import UIKit

class StudentsListViewController: UIViewController {
    var selectedSchool: School?
    var students: Set<Student> = [] {
        didSet{
            bStudents.removeAll()
            bStudents.append(contentsOf: students)
            studentsListView.reloadData()
        }
    }
    var bStudents: [Student] = []
    
    @IBOutlet weak var studentsListView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        students = selectedSchool?.students as! Set<Student>
        studentsListView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addStudent(_ sender: Any) {
        let newStudent = Student(context: CoreDataManager.shared.context)
        newStudent.name = "I am in Second School"
        newStudent.rollNo = 0001
        newStudent.school = selectedSchool
        CoreDataManager.shared.save()
        CoreDataManager.shared.context.refreshAllObjects()
        students = selectedSchool?.students as! Set<Student>
        studentsListView.reloadData()
    }
}

extension StudentsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bStudents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentsCell")
        let aStudent = bStudents[indexPath.row]
        cell?.textLabel?.text = aStudent.name
        cell?.detailTextLabel?.text = "\(String(describing: aStudent.rollNo))"
        return cell ?? UITableViewCell()
    }
}

