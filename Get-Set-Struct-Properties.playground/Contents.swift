// Create a Struct with Properties: firstName, lastName, fullname, (private) birthday, and age
struct Student{
    //Stored Properties
    var firstName:String
    var lastName:String
    var studentID:String

    var _password:String? {
        didSet{
            print("Your password was changed from \(oldValue ?? "nil") to \(_password!)")
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
    
    var studentEmail: String {
        var email = String(firstName.prefix(1))
        email.append(lastName)
        email.append("@student.cascadia.edu")
        return email
    }
    
    var _securityQuestions: [String]? {
        didSet {
            print("Your security questions were changed from:")
            printSecurityQuestions(oldValue)
            print("to:")
            printSecurityQuestions(_securityQuestions)
        }
    }
    
    var securityQuestions: [String] {
        get {
            if let _securityQuestions = _securityQuestions { return _securityQuestions }
            return []
        }
        set {
            _securityQuestions = newValue
        }
    }
    
    private func printSecurityQuestions(_ questions: [String]?) {
        if let questions = questions {
            for question in questions {
                print(question)
            }
        }
    }
    
}

var Ian = Student(firstName: "Ian", lastName:"Bansenauer", studentID: "920111123", _password: nil, _securityQuestions: nil)

print("Initial password: " + Ian.password)
//Set Password
Ian.password = "testPassword"
Ian.password = "Fabul0_346"
print()
Ian.securityQuestions.append("What is my favorite color?")
print()
Ian.securityQuestions.append("What is my favorite animal?")


