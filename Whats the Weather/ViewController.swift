//
//  ViewController.swift
//  Whats the Weather
//
//  Created by Admin on 8/5/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var resultLbl: UILabel!
    @IBAction func getWeather(_ sender: Any) {
        if let url = URL(string: "http://www.weather-forecast.com/locations/"+cityTextField.text!.replacingOccurrences(of: " ", with: "-")+"/forecasts/latest") {
        let request = NSMutableURLRequest(url: url)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            var message = ""
            
            if error != nil {
                self.resultLbl.text = "Some error occur"
            }else {
                if let unwrapedData = data {
                    let dataString = NSString(data: unwrapedData, encoding: String.Encoding.utf8.rawValue)
                    var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                    if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                        if contentArray.count > 1 {
                            stringSeparator = "</span>"
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                            if newContentArray.count > 1 {
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                            }
                        }
                    }
                }
            }
            
            if message == "" {
                message = "The Weather is couldn't be found. Please try again"
            }
            
            DispatchQueue.main.sync(execute: {
                self.resultLbl.text = message
            })
        }
        task.resume()
        } else {
            resultLbl.text = "The Weather is couldn't be found. Please try again"
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

