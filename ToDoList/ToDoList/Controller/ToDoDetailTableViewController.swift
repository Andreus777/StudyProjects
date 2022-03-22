//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by Андрей Фокин on 19.10.21.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {

    @IBOutlet weak var textFieldOutlet: UITextField!
    @IBOutlet weak var confirmButtonOutlet: UIButton!
    @IBOutlet weak var currentDateOutlet: UILabel!
    @IBOutlet weak var dataPickerViewOutlet: UIDatePicker!
    @IBOutlet weak var textViewOutlet: UITextView!
    @IBOutlet weak var saveButtonOutlet: UIBarButtonItem!
    
    var todo: ToDo?
 
    
    var datePickerViewIsHidden = true
    let dateIndexPath = IndexPath(row: 0, section: 1)
    let datePickerViewIndexPath = IndexPath(row: 1, section: 1)
    let textViewIndexPath = IndexPath(row: 0, section: 2)

    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todo {
            navigationItem.title = "To-Do"
            textFieldOutlet.text = todo.title
            confirmButtonOutlet.isSelected = todo.isComplete
            dataPickerViewOutlet.date = todo.dueDate
            textViewOutlet.text = todo.notes
        } else {
        dataPickerViewOutlet.date = Date().addingTimeInterval(24*60*60)
        }
        updateCurrentDateOutlet(date: dataPickerViewOutlet.date)
        updateSaveButton()
    }

    func updateSaveButton(){
        saveButtonOutlet.isEnabled = textFieldOutlet.text?.isEmpty == false
    }
    
    func updateCurrentDateOutlet(date: Date){
        currentDateOutlet.text = ToDo.dateFormatter.string(from: dataPickerViewOutlet.date)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerViewIndexPath where datePickerViewIsHidden == true:
            return 0
        case textViewIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == dateIndexPath {
            tableView.deselectRow(at: indexPath, animated: true)
            datePickerViewIsHidden.toggle()
            currentDateOutlet.textColor = .black
            updateCurrentDateOutlet(date: dataPickerViewOutlet.date)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        updateSaveButton()
    }
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func isConfirmButtonTapped(_ sender: UIButton) {
        confirmButtonOutlet.isSelected.toggle()
    }
    @IBAction func dataPickerViewChanged(_ sender: UIDatePicker) {
        updateCurrentDateOutlet(date: sender.date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else {return}
        
        let title = textFieldOutlet.text!
        let date = dataPickerViewOutlet.date
        let confirmButton = confirmButtonOutlet.isSelected
        let notes = textViewOutlet.text
        
        todo = ToDo(title: title, isComplete: confirmButton, dueDate: date, notes: notes)
    }
    

}
