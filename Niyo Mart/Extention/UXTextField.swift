//
//  UXTextField.swift
//  Gron
//
//  Created by Abservetech on 10/03/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import UIKit

extension UITextField {
    
    var getText: String{
        return self.text ?? ""
    }
    
    func setInputViewDatePicker(mode : UIDatePicker.Mode = .date ,target: Any, selector: Selector, minimumDate : Date) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = mode //2
        datePicker.minimumDate = minimumDate
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
    func setPlaceHoldeColor(text : String , color : UIColor = UIColor.primaryColor){
          self.attributedPlaceholder = NSAttributedString(string: text,
          attributes: [NSAttributedString.Key.foregroundColor:color])
      }
    
}
