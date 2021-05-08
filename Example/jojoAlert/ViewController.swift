//
//  ViewController.swift
//  jojoAlert
//
//  Created by ccanedo on 05/07/2021.
//  Copyright (c) 2021 ccanedo. All rights reserved.
//

import UIKit
import jojoAlert

class ViewController: UIViewController {

    
    let alert = JojoAlert()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toast = UIButton(frame: CGRect(x: 16, y: 40, width: view.frame.width - 32 , height: 45))
        toast.addTarget(self, action: #selector(self.showToast), for: .touchUpInside)
        toast.backgroundColor = .black
        toast.setTitle("Toast", for: .normal)
        toast.titleLabel?.textAlignment = .center
        toast.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        
        let success = UIButton(frame: CGRect(x: 16, y: 105, width: view.frame.width - 32 , height: 45))
        success.addTarget(self, action: #selector(self.showSuccess), for: .touchUpInside)
        success.backgroundColor = .black
        success.setTitle("Alert Success", for: .normal)
        success.titleLabel?.textAlignment = .center
        success.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        
        let error = UIButton(frame: CGRect(x: 16, y: 158, width: view.frame.width - 32 , height: 45))
        error.addTarget(self, action: #selector(self.showError), for: .touchUpInside)
        error.backgroundColor = .black
        error.setTitle("Alert Error", for: .normal)
        error.titleLabel?.textAlignment = .center
        error.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        
        let info = UIButton(frame: CGRect(x: 16, y: 211, width: view.frame.width - 32 , height: 45))
        info.addTarget(self, action: #selector(self.showInfo), for: .touchUpInside)
        info.backgroundColor = .black
        info.setTitle("Alert Info", for: .normal)
        info.titleLabel?.textAlignment = .center
        info.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        
        let bottomSheet = UIButton(frame: CGRect(x: 16, y: 276, width: view.frame.width - 32 , height: 45))
        bottomSheet.addTarget(self, action: #selector(self.showBottomSheet), for: .touchUpInside)
        bottomSheet.backgroundColor = .black
        bottomSheet.setTitle("BottomSheet classic", for: .normal)
        bottomSheet.titleLabel?.textAlignment = .center
        bottomSheet.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        
        let bottomSheetAction = UIButton(frame: CGRect(x: 16, y: 329, width: view.frame.width - 32 , height: 45))
        bottomSheetAction.addTarget(self, action: #selector(self.showBottomSheetAction), for: .touchUpInside)
        bottomSheetAction.backgroundColor = .black
        bottomSheetAction.setTitle("BottomSheet action", for: .normal)
        bottomSheetAction.titleLabel?.textAlignment = .center
        bottomSheetAction.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        
        view.addSubview(toast)
        view.addSubview(success)
        view.addSubview(error)
        view.addSubview(info)
        view.addSubview(bottomSheet)
        view.addSubview(bottomSheetAction)
    }

    @objc func showToast(){
        alert.showToast(message: "Soy un toast", font: UIFont.systemFont(ofSize: 12.0, weight: .semibold), UIIcon: "airpods", ctx: self)
    }
    
    @objc func showSuccess(){
        alert.showAlertInfo(title: "Success", description: "I think you should mention or illustrate if Swimat handles formatting spaces between lines. That information is not illustrated or communicated either here or on the github page. As per the gif illustration, Xcode default formating handles that already. – user3144836", buttonTextLeft: "", buttonTextRight: "Cerrar", type: "success", on: self, leftButton: nil, rightButton: nil)
    }
    
    @objc func showError(){
        alert.showAlertInfo(title: "Error", description: "Alert Error", buttonTextLeft: "", buttonTextRight: "Cerrar", type: "error", on: self, leftButton: nil, rightButton: nil)
    }
    
    @objc func showInfo(){
        alert.showAlertInfo(title: "Info", description: "Alert info", buttonTextLeft: "", buttonTextRight: "Cerrar", type: "info", on: self, leftButton: nil, rightButton: nil)
    }
    @objc func showBottomSheet(){
        alert.showBottomSheet(whit: "BottomSheet", messagge: "I think you should mention or illustrate if Swimat handles formatting spaces between lines. That information is not illustrated or communicated either here or on the github page. As per the gif illustration, Xcode default formating handles that already. – user3144836 I think you should mention or illustrate if Swimat handles formatting spaces between lines. That information is not illustrated or communicated either here or on the github page. As per the gif illustration, Xcode default formating handles that already. – user3144836 I think you should mention or illustrate if Swimat handles formatting spaces between lines. That information is not illustrated or communicated either here or on the github page. As per the gif illustration, Xcode default formating handles that already. – user3144836", textActionbutton: "", actionButton: nil, on: self)
    }
    @objc func showBottomSheetAction(){
        
        let btn = UIButton()
        btn.addTarget(self, action: #selector(self.actionAlert), for: .touchUpInside)
        alert.showBottomSheet(whit: "BottomSheet", messagge: "I think you should mention or illustrate if Swimat handles formatting spaces between lines. That information is not illustrated or communicated either here or on the github page. As per the gif illustration, Xcode default formating handles that already. – user3144836", textActionbutton: "Cerrar", actionButton: btn, on: self)
    }
    @objc func actionAlert(){
        alert.dismissSheet()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

