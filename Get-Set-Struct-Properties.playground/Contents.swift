// Create a Struct with Properties: firstName, lastName, fullname, (private) birthday, and age
struct Student{
    //Stored Properties
    var firstName:String
    var lastName:String
    var studentID:String
    var birthYear:Int
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
    var age:Int { return 2019 - birthYear}
}

var Ian = Student(firstName: "Ian", lastName:"Bansenauer", studentID: "920111123", birthYear: 1998 ,_password: nil)

print("Initial password: " + Ian.password)
print(Ian.age)
//Set Password
Ian.password = "testPassword"
Ian.password = "Fabul0_346"
