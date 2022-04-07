// Create a Struct with Properties: firstName, lastName, fullname, (private) birthday, and age

import Foundation
struct Student{
    //Stored Properties
    var firstName:String
    var lastName:String
    var studentID:String
    var _password:String?
    private var birthday:Int?
    static var now:Date {return Date.init()}
    var _age:Int?
    
   {
        didSet{
            print("Your password was changed from \(oldValue) to \(_password!)")
        }
    }
    // Computed Properties
    var fullName:String { return "\(firstName) \(lastName)"}
    var password:String {
        get
        {
            // Password has been set
            if let _password = _password { return _password }
            // Provide initial, temporary password
            let last4 = studentID.suffix(4)
            return "\(lastName)\(last4)"
        }
        set{
            _password = newValue
        }
    }
    var age:Int {
        let currDate = Calendar.dateComponents()
        
}

var Ian = Student(firstName: "Ian", lastName:"Bansenauer", studentID: "920111123", _password: nil)

print("Initial password: " + Ian.password)
//Set Password
Ian.password = "testPassword"
Ian.password = "Fabul0_346"
