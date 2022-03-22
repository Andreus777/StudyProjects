//
//  AddRegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Андрей Фокин on 13.10.21.
//

import UIKit

protocol RegistrationTableViewControllerDelegate: AnyObject {
 func registrationTableViewController(_ controller: RegistrationTableViewController, didSave registration: Registration)
}

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {

    let checkInDataPickerIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDataPickerIndexPath = IndexPath(row: 3, section: 1)
    let checkInDataLabelIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDataLabelIndexPath = IndexPath(row: 2, section: 1)
    
    var roomType: RoomType?
    weak var delegate: RegistrationTableViewControllerDelegate?
    var registrationMy: Registration?

    @IBOutlet weak var firstNameOutlet: UITextField!
    @IBOutlet weak var lastNameOutlet: UITextField!
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var checkInDataLable: UILabel!
    @IBOutlet weak var checkOutDatalabel: UILabel!
    @IBOutlet weak var checkInDataPicker: UIDatePicker!
    @IBOutlet weak var checkOutDataPicker: UIDatePicker!
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfChildrenLable: UILabel!
    @IBOutlet weak var adultsNumberStepper: UIStepper!
    @IBOutlet weak var childrenNumberStepper: UIStepper!
    @IBOutlet weak var wifiSwitch: UISwitch!
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var registration: Registration? {
        guard let roomType = roomType else {return nil}
       
        let firstName = firstNameOutlet.text ?? ""
        let lastName = lastNameOutlet.text ?? ""
        let email = emailOutlet.text ?? ""
        let checkInDate = checkInDataPicker.date
        let checkOutDate = checkOutDataPicker.date
        let adultsNumber = Int(adultsNumberStepper.value)
        let childrenNumber = Int(childrenNumberStepper.value)
        let wifi = wifiSwitch.isOn
       
        
        return Registration(firstName: firstName, lastName: lastName,email: email, checkInDate: checkInDate,checkOutDate: checkOutDate, adultsNumber: adultsNumber, childrenNumber: childrenNumber, wifi: wifi, roomType: roomType)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wifiSwitch.isOn = false
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDataPicker.minimumDate = midnightToday
        checkInDataPicker.date = midnightToday
        updateDateView()
        updateGuestsNumber()
        updateRoomType()
        updateDoneButton()

    }
    
    @IBAction func textChanged(_: UITextField){
        updateDoneButton()
    }
        
    
    @IBAction func pickerDateChanged(_ sender: UIDatePicker) {
        updateDateView()
        updateDoneButton()
    }
    
   
    @IBAction func stepperTapped(_ sender: UIStepper) {
        updateGuestsNumber()
    }
    
    @IBAction func switchTapped(_ sender: UISwitch) {
        
    }
    
    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> SelectRoomTableViewController? {
        let selectRoomTypeController = SelectRoomTableViewController(coder: coder)
        selectRoomTypeController?.delegate = self
        selectRoomTypeController?.roomType = roomType
        return selectRoomTypeController
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func updateDateView() {
        checkInDataLable.text = dateFormatter.string(from: checkInDataPicker.date)
        checkOutDatalabel.text = dateFormatter.string(from: checkOutDataPicker.date)
        checkOutDataPicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: checkInDataPicker.date)
        
    }
    
    
    func updateGuestsNumber() {
        numberOfAdultsLabel.text = "\(Int(adultsNumberStepper.value))"
        numberOfChildrenLable.text = "\(Int(childrenNumberStepper.value))"
    }
    
    func updateRoomType(){
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        }
    }
    
    func updateDoneButton(){
        let firstName = firstNameOutlet.text ?? ""
        let lastName = lastNameOutlet.text ?? ""
        let email = emailOutlet.text ?? ""
        doneButton.isEnabled = !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty
    }
    
    func selectRoomTypeTableViewController(_ controller: SelectRoomTableViewController, didSelect roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    
    
    var isCheckInDateVisible: Bool = false{
        didSet {
            checkInDataPicker.isHidden = !isCheckInDateVisible
        }
    }
    
    var isCheckOutDateVisible: Bool = false{
        didSet {
            checkOutDataPicker.isHidden = !isCheckOutDateVisible
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDataPickerIndexPath where isCheckInDateVisible == false:
            return 0
        case checkOutDataPickerIndexPath where isCheckOutDateVisible == false:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == checkInDataLabelIndexPath && isCheckOutDateVisible == false {
            isCheckInDateVisible.toggle()
        } else if indexPath == checkOutDataLabelIndexPath && isCheckInDateVisible == false {
            isCheckOutDateVisible.toggle()
        } else if indexPath == checkInDataLabelIndexPath || indexPath == checkOutDataLabelIndexPath {
            isCheckInDateVisible.toggle()
            isCheckOutDateVisible.toggle()
        } else {
            return
        }
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    
       
        
//      return Registration(firstName: firstName, lastName: lastName,email: email, checkInDate: checkInDate,checkOutDate: checkOutDate, adultsNumber: adultsNumber, childrenNumber: childrenNumber, wifi: wifi, roomType: roomType!)
    }

