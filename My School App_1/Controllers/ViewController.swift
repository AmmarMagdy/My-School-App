//
//  ViewController.swift
//  My School App_1
//
//  Created by Afnan on 6/29/19.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var studentTable: UITableView!
    
    var studentList:[StudentInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        studentList = CoreDataHandler.getAllCoreDataInfo()
        
        studentTable.reloadData()
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
        
        let nameLabel = cell.viewWithTag(1) as! UILabel
        let addressLabe2 = cell.viewWithTag(2) as! UILabel
        let favSubjectLabe3 = cell.viewWithTag(3) as! UILabel
        let ageLabe4 = cell.viewWithTag(4) as! UILabel
        let dobLabel5 = cell.viewWithTag(5) as! UILabel
        
        nameLabel.text = studentList?[indexPath.row].studentName
        addressLabe2.text = studentList?[indexPath.row].studentAddress
        favSubjectLabe3.text = studentList?[indexPath.row].studentFavSubject
        ageLabe4.text = "Age: " + "\(studentList?[indexPath.row].studentAge ?? 0)"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateString = formatter.string(from: studentList?[indexPath.row].studentDOB ?? Date())
        dobLabel5.text = dateString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            studentList = CoreDataHandler.deleteCoreDataItem(student: studentList![indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}

