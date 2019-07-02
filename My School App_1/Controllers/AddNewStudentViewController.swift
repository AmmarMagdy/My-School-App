//
//  AddNewStudentViewController.swift
//  My School App_1
//
//  Created by Afnan on 6/29/19.
//

import UIKit

class AddNewStudentViewController: UIViewController {

    @IBOutlet weak var dobPicker: UIDatePicker!
    @IBOutlet weak var favSubject: UIPickerView!
    @IBOutlet weak var nameStudentTextField: UITextField!
    @IBOutlet weak var ageStudentTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var labelShowMessage: UILabel!
    
    var subjects = ["Math","Science","Arabic","English"]
    var favSubjectTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func doneBtnTapped(_ sender: UIButton) {
        
        let newStudent = StudentInfo(context: CoreDataHandler.getCoreDataObject())
        
        newStudent.studentName = nameStudentTextField.text
        newStudent.studentAddress = addressTextField.text
        newStudent.studentFavSubject = favSubjectTitle
        newStudent.studentAge = Int16(ageStudentTextField.text!) ?? 0
        newStudent.studentDOB = dobPicker.date
        
        CoreDataHandler.saveIntoCoreData(student: newStudent)
        
//        self.navigationController?.popViewController(animated: true)

        labelShowMessage.isHidden = true

        guard !(nameStudentTextField.text?.isEmpty ?? true),
         isValidName(name:  nameStudentTextField.text!) else {
            labelShowMessage.isHidden = false
            labelShowMessage.text = "Please Enter name"
            return
        }
       
        
    }
    
    func isValidName(name:String) -> Bool {
        let nameRegex = "[A-Z]"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return nameTest.evaluate(with: name)
    }
}

extension AddNewStudentViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjects.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subjects[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        favSubjectTitle = subjects[row]
    }

}
