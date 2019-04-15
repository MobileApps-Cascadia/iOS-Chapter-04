//
//  Copyright © 2015 Big Nerd Ranch
//

import UIKit
    // TODO: Mark the ViewController as conforming to the UITextFieldDelegate Protocol
class ConversionViewController: UIViewController, UITextFieldDelegate{ //, UITextFieldDelegate {
    
    @IBOutlet var fahrenheitTextField: UITextField!
    @IBOutlet var celsiusTextField: UITextField!
    
    //ViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTemp()
    }
    // Keyboard disappears when tapping the screen somewhere else
    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        fahrenheitTextField.resignFirstResponder()
        celsiusTextField.resignFirstResponder()
    }
    // DELEGATE METHOD : Review each character typed to decide to keep it (true) or not (false)
    // TODO: Modify code to reject (return false) if it finds any letters in the replacement string
    //  (hint-use Documentation to find a NSCharacterSet collection for letters, and a String method that finds a range using a NSCharacterSet)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        //kinda done the way you asked (maybe)
        let replacementTextHasLetters = string.rangeOfCharacter(from: CharacterSet.letters)
        
        if replacementTextHasLetters != nil || existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil{
            return false
        } else {
            return true
        }
        
        
    }
    // DELEGATE METHOD : textFieldDidBeginEditing - is called when the user selects the text field
    // TODO: Add and modify the method to build expectation for the output by changing the celsiusLabel when the input field is selected
    // modify the celsiusLabel text to be a single question mark
    // modify the celsiusLabel color to be 60% red, 60% green, and 40% blue (refer to the Developer Documentation for UIColor)

    func textFieldDidBeginEditing(_ textField: UITextField){
        
    }
    
    // EVENT HANDLER METHOD : Called when TextField is Changed (notice the optional binding)
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func celsiusFieldEditingChanged(_ celsiusTextField: UITextField){
        if let ctext = celsiusTextField.text, let v = Double(ctext){
            celsiusValue = Measurement(value: v, unit: .celsius)
        } else {
            celsiusValue = nil
        }
    }
    //Stored Properties for Fahrenheit Temperature Measurement w/Observer
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet { // this property observer will run after the property is assigned a value
            updateTemp()
        }
    }
    //Computed Property for Celsius Temperature Measurement (Read only property - getter without setter)
    var celsiusValue: Measurement<UnitTemperature>? {
        didSet{
            updateTemp()
            
        }
    }
    // Helper Functions
    func updateTemp() {
        if let fahrenheitValue = fahrenheitValue{
            let ctfValue = fahrenheitValue.converted(to: .celsius)
            celsiusTextField.text = numberFormatter.string(from: NSNumber(value: ctfValue.value))
        }
        else if let celsiusValue = celsiusValue {
            let ftcValue = celsiusValue.converted(to: .fahrenheit)
            fahrenheitTextField.text = numberFormatter.string(from: NSNumber(value: ftcValue.value))
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
