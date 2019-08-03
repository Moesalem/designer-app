//
//  TestImageAnimation.swift
//  DesignerApp
//
//  Created by Moe on 01/08/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//

import Foundation
import UIKit

class TestImageAnimation: UIViewController {
    
    var imageFullScreen = UIImageView()
    var startingFrame = CGRect()

    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageFullScreen.image = #imageLiteral(resourceName: "DumbiPic")
        imageFullScreen.contentMode = .scaleAspectFill
        imageFullScreen.isUserInteractionEnabled = true
//        imageFullScreen.frame = CGRect(x: 200, y: 200, width: 300, height: 300)
        imageFullScreen.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabAbleImage)))
        view.addSubview(imageFullScreen)
        
        imageFullScreen.translatesAutoresizingMaskIntoConstraints = false

        guard let startingFrame = imageFullScreen.superview?.convert(imageFullScreen.frame, to: nil) else {return}
        self.startingFrame = startingFrame
            imageFullScreen.centerYInSuperview()

        imageFullScreen.centerXInSuperview()
        widthConstraint = imageFullScreen.widthAnchor.constraint(equalToConstant: view.frame.width)
        heightConstraint = imageFullScreen.heightAnchor.constraint(equalToConstant: startingFrame.height + 100)

        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
    }
    
    @objc func tabAbleImage(sender: UITapGestureRecognizer) {
        print(imageFullScreen.frame)
        if let startingFrame = imageFullScreen.superview?.convert(imageFullScreen.frame
            , to: nil) {
            let zoomView = UIView()
            zoomView.backgroundColor = .red
            zoomView.frame = startingFrame
            view.addSubview(zoomView)
            print(zoomView.frame)

        }
//        imageFullScreen = sender.view as! UIImageView
//
//        let newImageView = UIImageView(image: imageFullScreen.image)
//        newImageView.backgroundColor = #colorLiteral(red: 0.4151936173, green: 0.412730217, blue: 0.4170902967, alpha: 1)
//        newImageView.contentMode = .scaleAspectFit
//
//        newImageView.isUserInteractionEnabled = true
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissFullscreenImage))
//        newImageView.addGestureRecognizer(tap)
//
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
//
//            self.imageFullScreen.addSubview(newImageView)
////            newImageView.fillSuperview(padding: .init(top: 30, left: 30, bottom: 30, right: 30))
//           print(newImageView.frame)
//           newImageView.anchor(top: self.view.topAnchor, leading:  self.view.leadingAnchor, bottom:  self.view.bottomAnchor, trailing:  self.view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
//
//
//            self.view.layoutIfNeeded()
//            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
//            self.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: -100)
//        }, completion: nil)
    }
    
    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
           
            if #available(iOS 11.0, *) {
                self.topConstraint =  self.imageFullScreen.topAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.topAnchor, constant:  self.startingFrame.origin.y + 100)
            }
            self.leadingConstraint = self.imageFullScreen.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:  self.startingFrame.origin.x + 100)
            self.widthConstraint = self.imageFullScreen.widthAnchor.constraint(equalToConstant:  self.startingFrame.width + 200)
            self.heightConstraint = self.imageFullScreen.heightAnchor.constraint(equalToConstant:  self.startingFrame.height + 200)
            
            [ self.topConstraint,  self.leadingConstraint,  self.widthConstraint,  self.heightConstraint].forEach({$0?.isActive = true})
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 0)
            self.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: 0)
            sender.view?.removeFromSuperview()
        }, completion: nil)
        
    }
}
