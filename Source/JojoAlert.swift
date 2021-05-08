//
//  CustoAlert.swift
//  Picnic
//
//  Created by InnovacionVO on 06/10/20.
//  Copyright © 2020 Monkey Valley. All rights reserved.
//

import Foundation
import UIKit


public class JojoAlert{
    
    public struct Constants {
        static let backgroundAlphaTo:CGFloat = 0.6
    }
    
    public init() {        }
    
    private let backgroundView:UIView = {
        let background = UIView()
        background.backgroundColor = .secondarySystemBackground
        background.alpha = 0.0
        return background
    }()
    
    private let alertView:UIView = {
        let alert = UIView()
        alert.backgroundColor = .systemBackground
        alert.layer.masksToBounds = true
        return alert
    }()
    
    
    public func dismissAlert(){
        
        alertView.alpha = 0
        for view in alertView.subviews{
            view.removeFromSuperview()
        }
        UIView.animate(withDuration: 0.25,animations:  {
            self.backgroundView.alpha = 0
        }, completion: { done in
            if(done){
                self.alertView.removeFromSuperview()
                self.backgroundView.removeFromSuperview()
            }
        })
    }
    
    public func dismissSheet(){
        dissmisBottomSheet()
    }
    
    @objc func actionCancelable(){
        self.dismissAlert()
    }
    @objc func dissmisBottomSheet(){
        UIView.animate(withDuration: 0.25,animations: {
//            self.backgroundView.frame.origin = CGPoint(x: 0, y: self.backgroundView.frame.height)
            self.alertView.frame.origin.y = self.backgroundView.frame.height
            self.backgroundView.alpha = 0.0
        }, completion: {_ in
            self.alertView.frame.origin.y = self.backgroundView.frame.height
            for view in self.alertView.subviews{
                view.removeFromSuperview()
            }
            self.alertView.removeFromSuperview()
            self.backgroundView.removeFromSuperview()
        })
    }
    
    public func showAlertLoading(on ViewController:UIViewController){
        
        guard let targetView = ViewController.view else {
            return
        }
        
        backgroundView.frame = targetView.bounds
        alertView.alpha = 1
        
        let cancelableAction = UITapGestureRecognizer(target: self, action: #selector(self.actionCancelable))
        backgroundView.addGestureRecognizer(cancelableAction)
        
        alertView.frame = CGRect(x: CGFloat((backgroundView.frame.width / 2) - 50 ) , y: CGFloat((backgroundView.frame.height / 2) - 50), width: 100, height: 100)
        alertView.frame.size.width = 100
        alertView.frame.size.height = 100
        alertView.layer.cornerRadius = 12
        
        let indicator = UIActivityIndicatorView()
        indicator.frame = alertView.bounds
        indicator.color = UIColor(red: 74/255, green: 34/255, blue: 181/255, alpha: 1.0)
        indicator.activityIndicatorViewStyle = .large
        indicator.startAnimating()
        indicator.isHidden = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        alertView.addSubview(indicator)
        
        indicator.centerXAnchor.constraint(equalTo: alertView.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: alertView.centerYAnchor).isActive = true
        
        targetView.addSubview(backgroundView)
        targetView.addSubview(alertView)
        UIView.animate(withDuration: 0.25) {
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        }
    }
    
    public func showAlertInfo(title:String, description:String, buttonTextLeft:String, buttonTextRight:String, type:String, on ViewController:UIViewController, leftButton:UIButton?, rightButton:UIButton?){
        
        guard let targetView = ViewController.view else {
            return
        }
        
        backgroundView.frame = targetView.bounds
        alertView.alpha = 1
        
        let cancelableAction = UITapGestureRecognizer(target: self, action: #selector(self.actionCancelable))
        backgroundView.addGestureRecognizer(cancelableAction)
        
        alertView.frame = CGRect(x: (targetView.frame.size.width/2) - ((targetView.frame.size.width - 80)/2), y: (targetView.frame.size.height/2) - 175, width: (targetView.frame.size.width - 80), height: 350)
        alertView.layer.cornerRadius = 12
        
        
        
        let imageAlert = UIImageView(frame: CGRect(x: (alertView.frame.size.width / 2) - 50, y: 28.0, width: 100.0, height: 100.0))
        
        let titleHeight = stringH(size: 19.0, str: title) + 8
        let lblTitle = UILabel(frame: CGRect(x:16.0, y: imageAlert.frame.origin.y + imageAlert.frame.height , width: alertView.frame.width - 32, height: titleHeight))
        lblTitle.text = title
        lblTitle.numberOfLines = 0
        lblTitle.textColor = .darkGray
        lblTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 19.0)
        lblTitle.textAlignment = .center
        
        var descriptionHeight = stringH(size: 15.0, str: description) + 16
        
        if descriptionHeight >= 110{
            descriptionHeight = 110.0
        }
        
        let subtitle = UILabel(frame: CGRect(x:16.0, y: lblTitle.frame.origin.y + lblTitle.frame.height + 4 , width: alertView.frame.width - 32, height: descriptionHeight))
        subtitle.numberOfLines = 0
        subtitle.font = UIFont(name: "HelveticaNeue", size: 15.0)
        subtitle.text = description
        subtitle.textColor = .darkGray
        subtitle.textAlignment = .center
        
        
        
        
        var buttonRight = UIButton()
        
        if(rightButton != nil){
            buttonRight = rightButton!
        }else{
            buttonRight.addTarget(self, action: #selector(self.actionCancelable), for: .touchUpInside)
        }
        
        if(leftButton != nil) {
            let buttoneft = leftButton
            
            buttoneft!.frame = CGRect(x: 16, y: alertView.frame.height - 65, width: (alertView.frame.width / 2) - 24, height: 45)
            buttonRight.frame = CGRect(x: 40 + buttoneft!.frame.width, y: alertView.frame.height - 65, width: (alertView.frame.width / 2) - 32, height: 45)
            
            buttoneft!.backgroundColor = .systemBackground
            buttoneft!.layer.borderWidth = 1.0
            buttoneft!.layer.borderColor = UIColor.lightGray.cgColor
            buttoneft!.setTitle(buttonTextLeft, for: .normal)
            buttoneft!.setTitleColor(.white, for: .normal)
            buttoneft!.layer.cornerRadius = 8.0
            alertView.addSubview(buttoneft!)
        }else {
            
            buttonRight.frame = CGRect(x: 16, y: alertView.frame.height - 65, width: alertView.frame.width - 32, height: 45)
        }
        
        
        buttonRight.backgroundColor = UIColor(red: 74/255, green: 34/255, blue: 181/255, alpha: 1.0)
        buttonRight.setTitle(buttonTextRight, for: .normal)
        buttonRight.setTitleColor(.white, for: .normal)
        buttonRight.layer.cornerRadius = 8.0
        
        imageAlert.contentMode = .scaleAspectFit
        imageAlert.image = nil
        
        switch type {
        case "success":
            imageAlert.image = UIImage(systemName: "checkmark.seal")
        case "error":
            imageAlert.image = UIImage(systemName: "xmark.octagon")
        case "info":
            imageAlert.image = UIImage(systemName: "info.circle")
        default:
            imageAlert.image = UIImage(systemName: "sun.dust")
        }
        
        
        alertView.addSubview(lblTitle)
        alertView.addSubview(buttonRight)
        alertView.addSubview(subtitle)
        alertView.addSubview(imageAlert)
        
        
        
        targetView.addSubview(backgroundView)
        targetView.addSubview(alertView)
        UIView.animate(withDuration: 0.25) {
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        }
    }
    
    
    
    public func showBottomSheet(whit tilte:String, messagge:String, textActionbutton:String, actionButton:UIButton?,  on ctx:UIViewController){
        guard let targetView = ctx.view else {
            return
        }
        
        
        let widthBackgroundView = targetView.frame.width
        let heightBackgroundView = targetView.frame.height
        
        let heightAlert = 300
        
        let originYbutton = 10
        let originYviewcoments = 12
        let heightCloseButton = 32
        
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        backgroundView.frame.size = targetView.frame.size
        backgroundView.frame.origin = CGPoint(x: 0, y: 0)
        
        alertView.backgroundColor = .secondarySystemBackground
        alertView.alpha = 1.0
        alertView.frame.size = CGSize(width: CGFloat(widthBackgroundView) - 16.0 , height: CGFloat(heightAlert))
        alertView.frame.origin = CGPoint(x: 8, y: targetView.frame.height )
        alertView.layer.cornerRadius = 15.0
        
        
        let button = UIButton(frame:  CGRect(x: alertView.frame.width - 48, y: CGFloat(originYbutton), width: CGFloat(heightCloseButton), height: CGFloat(heightCloseButton)))
        button.backgroundColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        button.layer.cornerRadius = 16.0
        button.setImage( UIImage(systemName: "xmark") , for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(self.dissmisBottomSheet), for: .touchUpInside)
        
        
        let title = UILabel(frame:  CGRect(x: 8, y: button.frame.origin.y  + button.frame.height + CGFloat(originYviewcoments) , width: alertView.frame.width - 16, height: 20))
        title.text = tilte
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        title.textColor = .lightGray
        
        
        var descriptionHeight = stringH(size: 15.0, str: messagge) + 16
        if descriptionHeight >= 200{ descriptionHeight = 200}
        let description = UILabel(frame:  CGRect(x: 8, y: title.frame.origin.y + title.frame.height + 8.0 , width: alertView.frame.width - 16, height: descriptionHeight))
        description.text = messagge
        description.textAlignment = .center
        description.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        description.textColor = .darkGray
        description.numberOfLines = 0
        
        var buttonAction = UIButton()
        
        if(actionButton != nil){
            buttonAction = actionButton!
        }
        
        buttonAction.frame = CGRect(x: 8, y: alertView.frame.height - 60 , width: alertView.frame.width - 16, height: 45)
        buttonAction.layer.cornerRadius = 10
        buttonAction.backgroundColor = UIColor(red: 74/255, green: 34/255, blue: 181/255, alpha: 1.0)
        buttonAction.setTitleColor(.white, for: .normal)
        buttonAction.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        buttonAction.clipsToBounds = true
        buttonAction.setTitle(textActionbutton, for: .normal)
        
        
        
        let indicator = UIActivityIndicatorView(frame: CGRect(x: alertView.frame.width - 30, y: alertView.frame.height + 41, width: 20.0, height: 20.0))
        indicator.color = .white
        indicator.isHidden = false
        
        
        if(actionButton != nil){
            alertView.addSubview(buttonAction)
            buttonAction.addSubview(indicator)
        }
        
        alertView.addSubview(title)
        alertView.addSubview(description)
        alertView.addSubview(button)
        
        backgroundView.addSubview(alertView)
        targetView.addSubview(backgroundView)
        
        
        
        UIView.animate(withDuration: 0.25,animations: {
            self.alertView.frame.origin.y = heightBackgroundView - 316
            self.backgroundView.alpha = 1.0
//            self.backgroundView.frame.origin = CGPoint(x: 0, y: 0)
        }, completion: {_ in
            self.backgroundView.alpha = 1.0
        })
        
    }
    
    
    public func showToast(message : String, font: UIFont, UIIcon:String, ctx:UIViewController) {
        guard let targetView = ctx.view else {
            return
        }
        
        let backgroundViewToast:UIView = {
            let background = UIView()
            background.backgroundColor = .secondarySystemBackground
            background.alpha = 0.0
            return background
        }()
        
        let alertViewToast:UIView = {
            let alert = UIView()
            alert.backgroundColor = .systemBackground
            alert.layer.masksToBounds = true
            return alert
        }()
        
        let widthBackgroundView = targetView.frame.width
        let heightBackgroundView = targetView.frame.height
        
        let heightAlert = 100
        
        backgroundViewToast.backgroundColor = .clear
        backgroundViewToast.frame.size = targetView.frame.size
        backgroundViewToast.frame.origin = CGPoint(x: 0, y: targetView.frame.height)
        
        alertViewToast.backgroundColor = .clear
        alertViewToast.frame.size = CGSize(width: CGFloat(widthBackgroundView) - 16.0 , height: CGFloat(heightAlert))
        alertViewToast.frame.origin = CGPoint(x: 8, y: heightBackgroundView - 165 )
        
        
        
        
        let toastLabel = UILabel()
        
        toastLabel.backgroundColor = UIColor.clear
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 26;
        toastLabel.clipsToBounds  =  true
        
        
        let bodyToast = UIView()
        bodyToast.backgroundColor = UIColor.systemGray.withAlphaComponent(0.6)
        bodyToast.layer.cornerRadius = 26;
        bodyToast.clipsToBounds  =  true
        
        
        
        
        var width = stringW(size: font.pointSize , str: message)  + 58
        let height = stringH(size: font.pointSize , str: message) + 36
        
        
        var sizeToast = CGSize(width: width, height: height )
        
        if(width >= alertViewToast.frame.width ){
            width = alertViewToast.frame.width
            sizeToast =  CGSize(width: alertViewToast.frame.width, height: height  )
            toastLabel.frame.size = CGSize(width: alertViewToast.frame.width - 40, height: height  )
        }else{
            sizeToast =  CGSize(width: width, height: height )
            toastLabel.frame.size = CGSize(width: width - 40, height: height )
        }
        
        
        let  posX = CGFloat(alertViewToast.frame.width/2) - CGFloat(width/2)
        let  posY = CGFloat(alertViewToast.frame.height/2) - CGFloat(height/2)
        
        toastLabel.frame.origin = CGPoint(x: posX + 40 , y: posY)
        bodyToast.frame.size = sizeToast
        bodyToast.frame.origin = CGPoint(x: posX  , y: posY)
        
        
        let icon = UIImageView()
        icon.image = UIImage(systemName: UIIcon)
        icon.frame = CGRect(x: posX + 8, y: (posY + height/2) - CGFloat(16), width: 32, height: 32)
        icon.contentMode = .center
        icon.layer.cornerRadius = 16
        icon.tintColor = UIColor.white
        
        toastLabel.alpha = 1.0
        bodyToast.alpha = 1.0
        icon.alpha = 1.0
        
        alertViewToast.addSubview(bodyToast)
        alertViewToast.addSubview(icon)
        alertViewToast.addSubview(toastLabel)
        
        targetView.addSubview(backgroundViewToast)
        targetView.addSubview(alertViewToast)
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
            bodyToast.alpha = 0.0
            icon.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
            bodyToast.removeFromSuperview()
            icon.removeFromSuperview()
            
            for view in alertViewToast.subviews{
                view.removeFromSuperview()
            }
            
            alertViewToast.removeFromSuperview()
            backgroundViewToast.removeFromSuperview()
            
        })
        
        
    }
    
    func stringW(size:CGFloat, str:String) -> CGFloat {
        let constraintRect = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
        let boundingBox = str.trimmingCharacters(in: .whitespacesAndNewlines).boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size)], context: nil)
        return boundingBox.width
    }
    
    func stringH(size:CGFloat, str:String) -> CGFloat {
        let constraintRect = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
        let boundingBox = str.trimmingCharacters(in: .whitespacesAndNewlines).boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size)], context: nil)
        return boundingBox.height
    }
}
//extension String {
//     var stringWidth: CGFloat {
//        let constraintRect = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
//        let boundingBox = self.trimmingCharacters(in: .whitespacesAndNewlines).boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
//        return boundingBox.width
//    }
//
//    var stringHeight: CGFloat {
//        let constraintRect = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
//        let boundingBox = self.trimmingCharacters(in: .whitespacesAndNewlines).boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
//        return boundingBox.height
//    }
//}
