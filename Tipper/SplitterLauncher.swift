//
//  SplitterLauncher.swift
//  Tipper
//
//  Created by SB on 7/28/20.
//  Copyright © 2020 SB. All rights reserved.
//

import UIKit

class SplitterLauncher: NSObject {
    var containerView: UIView!
    
    // Bring up the bill split view
    func showSplitView() {
        
        if let window = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
            .filter({$0.isKeyWindow}).first {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.containerView.frame = CGRect(x: 0, y: (window.frame.height-self.containerView.frame.height), width: self.containerView.frame.width, height: self.containerView.frame.height)
            }, completion: nil)
        }
    }
    
    // Get rid of the bill split view
    func dismissSplitView() {
        UIView.animate(withDuration: 0.5, animations: {
            
            if let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
                .filter({$0.isKeyWindow}).first {
                self.containerView.frame = CGRect(x: 0, y: window.frame.height, width: self.containerView.frame.width, height: self.containerView.frame.height)
            }
        })
    }
}
