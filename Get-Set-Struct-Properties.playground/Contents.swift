// Create a Struct with Properties: firstName, lastName, fullname, (private) birthday, and age
let currentYear:Int = 2020;
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
    var birthday:String
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
    var age:Int{
        let bYear = Int(birthday.suffix(4)) ?? 0
        return currentYear - bYear
    }
}

var Ian = Student(firstName: "Ian", lastName:"Bansenauer", studentID: "920111123", _password: nil, birthday:"1/1/1978")

print("Initial password: " + Ian.password)
print("\(Ian.fullName)'s age is \(Ian.age)")
//Set Password
Ian.password = "testPassword"
Ian.password = "\(Ian.firstName)\(Ian.age)\(Ian.lastName)"
Ian.password = "Fabul0_346"
