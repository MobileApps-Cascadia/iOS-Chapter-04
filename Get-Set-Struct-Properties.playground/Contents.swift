// Create a Struct with Properties: firstName, lastName, fullname, (private) birthday, and age
struct Student{
    //Stored Properties
    var firstName:String
    var lastName:String
    var studentID:String
    var _password:String? {
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
    var student_id:String { return studentID }
}

var Ian = Student(firstName: "Ian", lastName:"Bansenauer", studentID: "920111123", _password: nil)

print("Initial password: " + Ian.password)
//Set Password
Ian.password = "testPassword"
Ian.password = "Fabul0_346"
print("Your Student ID is: " + Ian.student_id)
