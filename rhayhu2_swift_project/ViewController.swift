//
//
// Bob Hayhurst
// Project for App Development Class
// UIC Spring 2016
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate
{

    //
    // these are all outlets -- the values in the field
    // drive the actions, but they in of themselves don't
    // do anything except contain information
    //
    @IBOutlet weak var month1:  UITextField!
    @IBOutlet weak var day1:    UITextField!
    @IBOutlet weak var year1:   UITextField!
    @IBOutlet weak var month2:  UITextField!
    @IBOutlet weak var day2:    UITextField!
    @IBOutlet weak var year2:   UITextField!
    @IBOutlet weak var display: UILabel!
    
    @IBAction func calculate(sender: AnyObject)
    {
        //
        // convert text strings to <Optional>Int
        //
        let m1:Int? = Int(month1.text!)
        let m2:Int? = Int(month2.text!)
        let d1:Int? = Int(day1.text!)
        let d2:Int? = Int(day2.text!)
        let y1:Int? = Int(year1.text!)
        let y2:Int? = Int(year2.text!)
        
        //
        // then make sure that the optionals aren't nil
        //
        if (m1 == nil || m2 == nil || d1 == nil || d2 == nil || y1 == nil || y2 == nil)
        {
            display.text = "All fields must have numeric values."
        }
        else // the optionals have values, and we can continue
        {
            //
            // intialize the date objects
            //
            let date1 = GregorianDate(month:m1!, day:d1!, year:y1!)
            let date2 = GregorianDate(month:m2!, day:d2!, year:y2!)
            
            //
            // print the dates (for debugging)
            //
            print("Date 1, Month = \(date1.month), Day = \(date1.day), year = \(date1.year)")
            print("Date 2, Month = \(date2.month), Day = \(date2.day), year = \(date2.year)")
            
            //
            // error check the entries -- if no error, the display will still be blank
            //
            display.text = date1.errorCheck()
            if display.text == ""
            {
                display.text = date2.errorCheck()
                if (display.text == "")
                {
                    //
                    // if the display text is empty, then no errors occurred, and we can continue
                    //
                    if display.text == ""
                    {
                        let jNum1 = date1.getJulianNumber()
                        let jNum2 = date2.getJulianNumber()
                        if checkForDateError(jNum1, j2:jNum2)
                        {
                            display.text = "Number of days: \(jNum2-jNum1)"
                        }
                        else
                        {
                            display.text = "Second date cannot be earlier than first"
                        }
                    }
                }
            }
        }
        
        //
        // turn off keyboard after clicking button
        //
        self.month1.resignFirstResponder()
        self.day1  .resignFirstResponder()
        self.year1 .resignFirstResponder()
        self.month2.resignFirstResponder()
        self.day2  .resignFirstResponder()
        self.year2 .resignFirstResponder()
        
    }
    
    func checkForDateError(j1:Int, j2:Int)->Bool
    {
        if j2-j1 < 1 {return false}
        return true
    }
    
    func errorCheckSecondYearIsAfterFirstYear(m1 : Int, m2:Int, d1: Int, d2: Int, y1: Int, y2:Int)->Bool
    {
        if y2<y1 {return false}
        if y2 == y1
        {
            if m2<m1 { return false }
            else if m2==m1
            {
                if d2<d1 || d2==d1 {return false}
                else               {return true}
            }
        }
        return true
    }
    
    //
    // Method from our protocol "UITextFieldDelegate" turns off
    // the keyboard when "GO" is hit
    //
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return false
    }
    
    //
    // keyboard turns off when a blank part of the screen is touched
    //
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
 
 


