//
//  Extensions.swift
//  Racer
//
//  Created by Ingrid on 11/02/2021.
//

import Foundation
import UIKit

extension UIView {
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    
    public var left: CGFloat {
        return self.frame.origin.x
    }
    
    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
    
    public var safeAreaHeight: CGFloat{
        return self.safeAreaLayoutGuide.layoutFrame.height
    }
    

    
    
    
}

extension Notification.Name {
    
    static let didLogInNotification = Notification.Name("didLogInNotification")
    
}
