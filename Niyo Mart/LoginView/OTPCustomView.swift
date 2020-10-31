//
//  OTPCustomView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 24/08/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

protocol customOtpViewDelegate : NSObjectProtocol {
    func next(enteredText : String)
    func delete(deletedText :String)
}

class OTPCustomView: UIStackView {

    var textFieldArray = [OTPTextField]()
    var numberOfOTPdigit = 6
    var delegate : customOtpViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStackView()
        setTextFields()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
        setTextFields()
    }
    
    private func setupStackView() {
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .center
        self.distribution = .fillEqually
        self.spacing = 5
    }
    
    private func setTextFields() {
        for i in 0..<numberOfOTPdigit {
            let field = OTPTextField()
        
            textFieldArray.append(field)
            addArrangedSubview(field)
            field.delegate = self
            field.textColor = .darkText
            field.backgroundColor = .lightGray
            field.layer.opacity = 0.5
            field.textAlignment = .center
            field.layer.shadowColor = UIColor.black.cgColor
            field.layer.shadowOpacity = 0.1
            
            i != 0 ? (field.previousTextField = textFieldArray[i-1]) : ()
            i != 0 ? (textFieldArray[i-1].nextTextFiled = textFieldArray[i]) : ()
        }
    }
}


extension OTPCustomView : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let field = textField as? OTPTextField else {
            return true
        }
        if !string.isEmpty {
            field.text = string
            print("field.text : \(field.text ?? "")")
            delegate?.next(enteredText: string)
            field.resignFirstResponder()
            field.nextTextFiled?.becomeFirstResponder()
            return true
        }else {
            print("empty")
            delegate?.delete(deletedText: "")
        }
        return true
    }
    
    
}

class OTPTextField: UITextField {
    var previousTextField: UITextField?
    var nextTextFiled: UITextField?
    
    var otpDelegate : customOtpViewDelegate?
    
    override func deleteBackward() {
        text = ""
        previousTextField?.becomeFirstResponder()
    }
}
