//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit

// Make ConversionViewController adopt UITextFieldDelegate protocol
class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    // Outlets to UITextField interface builder objects
    @IBOutlet var celsiusField: UITextField!
    @IBOutlet var fahrenheitField: UITextField!
    
    // Stored Properties for Temperature Measurement
     var fahrenheitValue: Measurement<UnitTemperature>?
     var celsiusValue: Measurement<UnitTemperature>?
    
    // Initial value for UITextFields
    let notTappedYet = "???"
    
    //ViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        fahrenheitField.delegate = self
        celsiusField.delegate = self
        updateCelsiusField()
        updateFahrenheitField()
    }
    
    // Keyboard disappears when tapping the screen somewhere else
    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        fahrenheitField.resignFirstResponder()
        celsiusField.resignFirstResponder()
    }
    
    // DELEGATE METHOD : Review each character typed to decide to keep it (true) or not (false)
    // TODO: Modify code to reject (return false) if it finds any letters in the replacement string
    //  (hint-use Documentation to find a NSCharacterSet collection for letters, and a String method that finds a range using a NSCharacterSet)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = textField.text?.contains(".") ?? false
        let replacementTextHasDecimalSeparator = string.contains(".")
        let replacementTextHasAcceptableValues = string.rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789."))
        
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b") == -92

        if isBackSpace {
            return true
        }
        
        if existingTextHasDecimalSeparator && replacementTextHasDecimalSeparator || replacementTextHasAcceptableValues == nil {
            return false
        } else {
            return true
        }
        
    }
    
    // DELEGATE METHOD : textFieldDidBeginEditing - is called when the user selects the text field
    // TODO: Add and modify the method to build expectation for the output by changing the celsiusLabel when the input field is selected
    // modify the celsiusLabel text to be a single question mark
    // modify the celsiusLabel color to be 60% red, 60% green, and 40% blue (refer to the Developer Documentation for UIColor)
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text == notTappedYet {
            textField.text = ""
        }
        
        if textField == fahrenheitField {
            celsiusField.text = "?"
            celsiusField.textColor = .yellowGray
            fahrenheitField.textColor = .mainOrange
        } else {
            fahrenheitField.text = "?"
            fahrenheitField.textColor = .yellowGray
            celsiusField.textColor = .mainOrange
        }

    }
    
    // EVENT HANDLER METHOD : Called when TextField is Changed (notice the optional binding)
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
            celsiusValue = fahrenheitValue?.converted(to: .celsius)
            updateCelsiusField()
        } else {
            fahrenheitValue = nil
        }
        
    }
    
    @IBAction func celciusFieldEditingChanged(_ textField: UITextField) {
        
        if let text = textField.text, let value = Double(text) {
            celsiusValue = Measurement(value: value, unit: .celsius)
            fahrenheitValue = celsiusValue?.converted(to: .fahrenheit)
            updateFahrenheitField()
        } else {
            celsiusValue = nil
        }
        
    }
    
    // Helper Functions
    func updateCelsiusField() {
        
        if let celsiusValue = celsiusValue {
            celsiusField.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusField.text = notTappedYet
        }
        
    }
    
    func updateFahrenheitField() {
        
        if let farenheitValue = fahrenheitValue {
            fahrenheitField.text = numberFormatter.string(from: NSNumber(value: farenheitValue.value))
        } else {
            fahrenheitField.text = notTappedYet
        }
        
    }
    
    // Limits the number of decimal places in the output label to 1
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
}

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let mainOrange = UIColor.rgb(red: 225, green: 88, blue: 41)
    static let yellowGray = UIColor(red: 0.6, green: 0.6, blue: 0.4, alpha: 1)
    
}
