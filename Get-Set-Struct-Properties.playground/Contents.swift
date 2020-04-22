// Create a Struct with Properties: firstName, lastName, fullname, (private) birthday, and age
struct Student{
    //Stored Properties
    var firstName:String
    var _lastName:String? {
        didSet {
            print("Your last name changed from \(oldValue) to \(_lastName!)")
        }
    }
    
    var lastName:String? {
        get
        {
            return _lastName
        }
        set{
            _lastName = newValue
        }
    }
    
    var studentID:String
    var _password:String? {
        didSet{
            print("Your password was changed from \(oldValue) to \(_password!)")
        }
    }
    // Computed Properties
    var fullName:String {
        return "\(firstName) \(_lastName)"
        
    }
    
    var password:String {
        get
        {
            // Password has been set
            if let _password = _password {
                return _password
            }
            // Provide initial, temporary password
            let last4 = studentID.suffix(4)
            return "\(_lastName)\(last4)"
        }
        set{
            _password = newValue
        }
    }
}




var Ian = Student(firstName: "Ian", _lastName:"Bansenauer", studentID: "920111123", _password: nil)

print("Initial password: " + Ian.password)
//Set Password
Ian.password = "testPassword"
Ian.password = "Fabul0_346"
Ian.password = "Covid-19"
Ian.lastName = "Smith"
