//
//  Extension.swift
//  Talabat
//
//  Created by Mohamed Hadwa on 19/02/2023.
//

import Foundation
import UIKit

extension UIView {
    
    /* The color of the shadow. Defaults to opaque black. Colors created
    * from patterns are currently NOT supported. Animatable. */
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue?.cgColor
        } get {
            if let color = layer.shadowColor{
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }
    
    /* The opacity of the shadow. Defaults to 0. Specifying a value outside the
    * [0,1] range will give undefined results. Animatable. */

    @IBInspectable var shadowOpacity: Float{
        set {
            layer.shadowOpacity = newValue
        } get {
            return layer.shadowOpacity
        }
    }
    
    /* The shadow offset. Defaults to (0, -3). Animatable. */
    @IBInspectable var shadowOffset: CGPoint {
        set {
            self.layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }
    
    /* The blur radius used to create the shadow. Defaults to 3. Animatable. */
    @IBInspectable var shadowRadius: CGFloat {
        set {
            self.layer.shadowRadius = newValue
        }
        get {
            return self.layer.shadowRadius
        }
    }
    
    /* cornerRadius View */
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        } get {
            return layer.cornerRadius
        }
    }
    
    
    @IBInspectable var topLeft: Bool {
        get { return layer.maskedCorners.contains(.layerMinXMinYCorner) }
        set {
            if newValue {
                layer.maskedCorners.insert(.layerMinXMinYCorner)
            } else {
                layer.maskedCorners.remove(.layerMinXMinYCorner)
            }
        }
    }

    @IBInspectable var topRight: Bool {
        get { return layer.maskedCorners.contains(.layerMaxXMinYCorner) }
        set {
            if newValue {
                layer.maskedCorners.insert(.layerMaxXMinYCorner)
            } else {
                layer.maskedCorners.remove(.layerMaxXMinYCorner)
            }
        }
    }

    @IBInspectable var bottomLeft: Bool {
        get { return layer.maskedCorners.contains(.layerMinXMaxYCorner) }
        set {
            if newValue {
                layer.maskedCorners.insert(.layerMinXMaxYCorner)
            } else {
                layer.maskedCorners.remove(.layerMinXMaxYCorner)
            }
        }
    }

    @IBInspectable var bottomRight: Bool {
        get { return layer.maskedCorners.contains(.layerMaxXMaxYCorner) }
        set {
            if newValue {
                layer.maskedCorners.insert(.layerMaxXMaxYCorner)
            } else {
                layer.maskedCorners.remove(.layerMaxXMaxYCorner)
            }
        }
    }
    
    /* Circle View */
    @IBInspectable var isCircle: Bool {
        set {
            layer.cornerRadius = self.frame.size.width / 2
        } get {
            return self.isCircle
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
         get {
             return layer.borderWidth
         } set {
             layer.borderWidth = newValue
         }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        } set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
}


extension UIView {
    func gradientColor (){
        
        let lineWidth: CGFloat = 1.5
        let rect = self.bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 5)
        
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.frame.size)
        
        gradient.colors = [#colorLiteral(red: 0.5098039216, green: 0.4666666667, blue: 0.7843137255, alpha: 0.9871357292).cgColor, #colorLiteral(red: 0.7568627451, green: 0.7254901961, blue: 1, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 1)
        gradient.endPoint = CGPoint(x: 0.5, y: 0)
        
        let shape = CAShapeLayer()
        shape.lineWidth = lineWidth
        
        shape.path = path.cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        self.layer.addSublayer(gradient)
    }
}
