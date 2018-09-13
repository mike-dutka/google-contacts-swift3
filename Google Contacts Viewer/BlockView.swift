//
//  BlockView.swift
//  Client
//
//  Created by Mykhailo Dutka on 7/6/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import UIKit

let kPasswdKey = "kPasswdKey"

class BlockView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup(){
        self.backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.5294117647, blue: 0.5764705882, alpha: 1)
        
        let lbl = UILabel(frame: CGRect(x: 5, y:5, width:20, height:20))
        lbl.backgroundColor = self.backgroundColor
        lbl.textColor = .lightGray
        lbl.text = "+"
        self.addSubview(lbl)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleAction))
        tapRecognizer.numberOfTapsRequired = 3
        
        let tapUpdateRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSetPassword))
        tapUpdateRecognizer.numberOfTapsRequired = 4
        
        tapRecognizer.require(toFail: tapUpdateRecognizer)
        
        self.addGestureRecognizer(tapRecognizer)
        self.addGestureRecognizer(tapUpdateRecognizer)
    }
    
    @objc func handleAction() {
        guard let pwd = UserDefaults.standard.string(forKey: kPasswdKey), (pwd.isEmpty == false) else {
            handleSetPassword()
            return
        }
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.textAlignment = .center
            textField.keyboardType = .phonePad
            textField.isSecureTextEntry = true
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let tf = alert.textFields?.first, (tf.text == pwd) {
                self.unhide()
            }
        }))
        
        UIApplication.shared.keyWindow!.rootViewController?.present(alert, animated: true, completion: {
            
        })
    }
    
    @objc func handleSetPassword(){
        let alert = UIAlertController(title: "Set PIN", message: "", preferredStyle: .alert)
        
        var oldPasswd: String?
        
        if let pwd = UserDefaults.standard.string(forKey: kPasswdKey), (pwd.isEmpty == false) {
            alert.addTextField { textField in
                textField.textAlignment = .center
                textField.keyboardType = .phonePad
                textField.isSecureTextEntry = true
                textField.placeholder = "old PIN"
            }
            
            oldPasswd = pwd
        }
        
        alert.addTextField { textField in
            textField.textAlignment = .center
            textField.keyboardType = .phonePad
            textField.isSecureTextEntry = true
            textField.placeholder = "PIN"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            let pinOld = (alert.textFields?.count == 2 ? alert.textFields?.first : nil)?.text
            let pinNew = (alert.textFields?.count == 2 ? alert.textFields?.last : alert.textFields?.first)?.text
            
            guard (pinOld == nil) || (pinOld! == oldPasswd) else {
                return
            }
            
            guard pinNew?.isEmpty == false else {
                return
            }
            
            UserDefaults.standard.setValue(pinNew!, forKey: kPasswdKey)
            UserDefaults.standard.synchronize()
            
            self.unhide()
        }))
        
        UIApplication.shared.keyWindow!.rootViewController?.present(alert, animated: true, completion: {
            
        })
    }
    
    func unhide() {
        self.removeFromSuperview()
    }
}
