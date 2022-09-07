//
//  redController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 1/09/22.
//

import UIKit

struct AnimationsController{
    
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
}
