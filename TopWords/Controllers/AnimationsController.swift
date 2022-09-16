//
//  redController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 1/09/22.
//

import UIKit

struct AnimationsController{
    
    var playCompareController: PlayCardsController?
    
    func constructOpacityAnimation(startingOpacity: CGFloat, endingOpacity: CGFloat, animationDuration: Double) -> CABasicAnimation {
        let opacityFadeAnimation = CABasicAnimation(keyPath: "opacity")
        opacityFadeAnimation.fromValue = startingOpacity
        opacityFadeAnimation.toValue = endingOpacity
        opacityFadeAnimation.duration = animationDuration
        //opacityFadeAnimation.autoreverses = true
        opacityFadeAnimation.repeatCount = 1//Float.infinity
        return opacityFadeAnimation
    }
    
    func constructRotationAnimation(animationDuration: Double) -> CABasicAnimation {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Double.pi*2
        rotationAnimation.duration = animationDuration
        rotationAnimation.repeatCount = Float.infinity

        return rotationAnimation
    }
    
    func constructScaleAnimation(startingScale: CGFloat, endingScale: CGFloat, animationDuration: Double) -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = startingScale
        scaleAnimation.toValue = endingScale
        scaleAnimation.duration = animationDuration
        //scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = Float.infinity
        return scaleAnimation
    }
    
    func constructPositionAnimation(startingPoint: CGPoint, endPoint: CGPoint, animationDuration: Double) -> CABasicAnimation {
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.fromValue = NSValue(cgPoint: startingPoint)
        positionAnimation.toValue = NSValue(cgPoint: endPoint)
        positionAnimation.duration = animationDuration
        //positionAnimation.autoreverses = true
        positionAnimation.repeatCount = 1//Float.infinity
        positionAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        return positionAnimation
    }
    
    func performObjectAnimation(point1: Double, point2: Double, object: UIView) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            object.alpha = 0
            object.transform = CGAffineTransform(translationX: 0, y: -point2)
        }) { (_) in
            UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                object.transform = CGAffineTransform(translationX: -point1, y: -point2)
            }) { (_) in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                    object.alpha = 1
                    object.transform = CGAffineTransform(translationX: -point1, y: 0)
                }) { (_) in
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                        object.transform = CGAffineTransform(translationX: 0, y: 0)
                    }, completion: { (_) in
                        
                    })
                }
            }
        }
    }
    
}
