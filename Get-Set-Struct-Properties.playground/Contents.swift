// Create a Struct with Properties: firstName, lastName, fullname, (private) birthday, and age
struct Student{
    //Stored Properties
    var firstName:String
    var lastName:String
    var studentID:String
    var birthday:String
    var _password:String? {
        didSet{
            print("Your password was changed from \(oldValue) to \(_password!)")
        }
    }
    // Computed Properties
    
    
    //TODO: Add another relative computed property
    //Gets the age that person will be at the end of 2019
    var age:Int {
        let birthYear = birthday.suffix(2)
        let bday:Int? = Int(birthYear)
        return 119 - bday!}
    
    var fullName:String { return "\(firstName) \(lastName)"}
    var password:String {
        mutating get
        {
            // Password has been set
            if let _password = _password { return _password }
            // Provide initial, temporary password
            
            //TODO: Bonus: Fix so that this actually sets the password to a default
            let last4 = studentID.suffix(4)
            _password = "\(lastName)\(last4)"
            return  "\(lastName)\(last4)"
        }
        set{
            _password = newValue
        }
    }
}

var Ian = Student(firstName: "Ian", lastName:"Bansenauer", studentID: "920111123", birthday: "122893", _password: nil)

print("Initial password: " + Ian.password)
//Set Password
Ian.password = "testPassword"
Ian.password = "Fabul0_346"
print("You are " + String(Ian.age) + " years old at the end of 2019")
