// Create a Struct with Properties: firstName, lastName, fullname, (private) birthday, and age
struct Student{
    //Stored Properties
    var firstName:String
    var lastName:String
    var studentID:String
    var _password:String? {
        // property observer (another one is willSet)
        didSet{
            print("Your password was changed from \(oldValue) to \(_password!)")
        }
    }
    var streetNumber:String
    var streetName:String
    var cityName:String
    var stateABV:String
    var zipCode:String
    
    // Computed Properties
    var fullName:String {
        return "\(firstName) \(lastName)"
    }
    
    var fullAddress:String {
        return "\(streetNumber) \(streetName), \(cityName) \(stateABV) \(zipCode)"
    }
    
    var streetAddress:String {
        return "\(streetNumber) \(streetName)"
    }
    
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
}

var Sharief = Student(firstName: "Sharief", lastName:"Youssef", studentID: "920111123", _password: nil, streetNumber: "19128", streetName: "112th Ave NE", cityName: "Bothell", stateABV: "WA", zipCode: "98011")

print("Name: " + Sharief.fullName)
print("Address: " + Sharief.fullAddress)
print("Initial password: " + Sharief.password)
//Set Password
Sharief.password = "testPassword"
Sharief.password = "Fabul0_346"
