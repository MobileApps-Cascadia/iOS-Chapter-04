//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit
    // TODO: Mark the ViewController as conforming to the UITextFieldDelegate Protocol
class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var fahrenheitTextField: UITextField!
    @IBOutlet var celsiusTextField: UITextField!
    
    //ViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTemperatureLabel()
    }
    // Keyboard disappears when tapping the screen somewhere else
    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        fahrenheitTextField.resignFirstResponder()
        celsiusTextField.resignFirstResponder()
        updateTemperatureLabel()
    }
    // DELEGATE METHOD : Review each character typed to decide to keep it (true) or not (false)
    // TODO: Modify code to reject (return false) if it finds any letters in the replacement string
    //  (hint-use Documentation to find a NSCharacterSet collection for letters, and a String method that finds a range using a NSCharacterSet)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        // assign a variable with a CharacterSet 'letters'
        let letters = CharacterSet.letters
        // assign a variable to
        let stringHasLetters = string.rangeOfCharacter(from: letters)
    
        
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            if stringHasLetters == nil { // if textHasLetters is nil then the string contains no letters
                return true
            } else {
                return false
            }
        }
    
    }
    // DELEGATE METHOD : textFieldDidBeginEditing - is called when the user selects the text field
    // TODO: Add and modify the method to build expectation for the output by changing the celsiusLabel when the input field is selected
    // modify the celsiusLabel text to be a single question mark
    // modify the celsiusLabel color to be 60% red, 60% green, and 40% blue (refer to the Developer Documentation for UIColor)
    //func textFieldDidBeginEditing(_ textField: UITextField) {
    //    celsiusLabel.textColor = UIColor.init(red: 0.60, green: 0.60, blue: 0.40, alpha: 100)
    //    celsiusLabel.text = "?"
    //}
    
    // EVENT HANDLER METHOD : Called when TextField is Changed (notice the optional binding)
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = fahrenheitTextField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    // EVENT HANDLER METHOD : Called when TextField is Changed (notice the optional binding)
    @IBAction func celsiusFieldEditingChanged(_ textField: UITextField) {
        if let text = celsiusTextField.text, let value = Double(text) {
            celsiusValue = Measurement(value: value, unit: .celsius)
        } else {
            celsiusValue = nil
        }
    }
    
    //Stored Properties for Fahrenheit Temperature Measurement w/Observer
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet { // this property observer will run after the property is assigned a value
            updateTemperatureLabel()
        }
    }
    //Stored Property for Celsius Temperature Measurement (Read only property - getter without setter)
    var celsiusValue: Measurement<UnitTemperature>? {
        didSet {
            updateTemperatureLabel()
        }
    }
    // Helper Functions
    func updateTemperatureLabel() {
        
        if let celsiusValue = celsiusValue {
            let cVal = celsiusValue.converted(to: .fahrenheit)
            fahrenheitTextField.text = numberFormatter.string(from: NSNumber(value: cVal.value))
        }
        else if let fahrenheit = fahrenheitValue{
            let fVal = fahrenheit.converted(to: .celsius)
            celsiusTextField.text = numberFormatter.string(from: NSNumber(value: fVal.value))
        }
        else {
            celsiusTextField.text = ""
            fahrenheitTextField.text = ""
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
