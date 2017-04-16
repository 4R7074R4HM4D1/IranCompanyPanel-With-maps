//
//  CircularSlider+Draw.swift
//  Pods
//
//  Created by Hamza Ghazouani on 21/10/2016.
//
//

import UIKit

extension CircularSlider {
    fileprivate class func toRad(_ degrees: Double) -> Double {
        return ((M_PI * degrees) / 180.0)
    }
    fileprivate class func compassToCartesian(_ radians: Double) -> Double {
        return radians - (M_PI/2)
    }
    
    /**
     Draw arc with stroke mode (Stroke) or Disk (Fill) or both (FillStroke) mode
     FillStroke used by default
     
     - parameter arc:           the arc coordinates (origin, radius, start angle, end angle)
     - parameter lineWidth:     the with of the circle line (optional) by default 2px
     - parameter mode:          the mode of the path drawing (optional) by default FillStroke
     - parameter context:       the context
     
     */
    internal static func drawArc(withArc arc: Arc, lineWidth: CGFloat = 2, mode: CGPathDrawingMode = .fillStroke, inContext context: CGContext) {
        let circle = arc.circle
        let origin = circle.origin
        
        UIGraphicsPushContext(context)
        context.beginPath()
        context.setLineWidth(lineWidth)
        
        context.addArc(center: origin, radius: circle.radius, startAngle: arc.startAngle, endAngle: arc.endAngle, clockwise: false)
        context.move(to: CGPoint(x: origin.x, y: origin.y))
        
        context.drawPath(using: mode)
        UIGraphicsPopContext()
    }
    
    internal static func DRAWArc(_ ctx: CGContext, center: CGPoint, radius: CGFloat, lineWidth: CGFloat, fromAngleFromNorth: CGFloat, toAngleFromNorth: CGFloat, lineCap: CGLineCap,colors: [UIColor]) {
        
        // ctx.addArc(center: CGPoint(x:center.x,y:center.y),radius: radius,startAngle: CGFloat(cartesianFromAngle), endAngle: CGFloat(cartesianToAngle),clockwise: false) // iOS flips the y coordinate so anti-clockwise (specified here by 0) becomes clockwise (desired)!
        ctx.saveGState()
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: fromAngleFromNorth, endAngle: toAngleFromNorth, clockwise: true)
        let containerPath = CGPath(__byStroking: path.cgPath, transform: nil, lineWidth: CGFloat(lineWidth), lineCap: lineCap, lineJoin: CGLineJoin.round, miterLimit: lineWidth)
        ctx.addPath(containerPath!)
        ctx.clip()
        
        let baseSpace = CGColorSpaceCreateDeviceRGB()
        var Colors = [colors[1].cgColor, colors[0].cgColor]
        let gradient = CGGradient(colorsSpace: baseSpace, colors: Colors as CFArray, locations: nil)
        let startPoint = CGPoint(x: center.x - radius, y: center.y + radius)
        let endPoint = CGPoint(x: center.x + radius, y: center.y - radius)
        ctx.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
        
        ctx.restoreGState()
        
        //    ctx.setLineWidth(lineWidth)
        //  ctx.setLineCap(lineCap)
        // ctx.drawPath(using: CGPathDrawingMode.stroke)
        
        
    }
    /**
     Draw disk using arc coordinates
     
     - parameter arc:     the arc coordinates (origin, radius, start angle, end angle)
     - parameter context: the context
     */
    internal static func drawDisk(withArc arc: Arc, inContext context: CGContext) {
        
        let circle = arc.circle
        let origin = circle.origin
        
        UIGraphicsPushContext(context)
        context.beginPath()
        
        context.setLineWidth(0)
        context.addArc(center: origin, radius: circle.radius, startAngle: arc.startAngle, endAngle: arc.endAngle, clockwise: false)
        context.addLine(to: CGPoint(x: origin.x, y: origin.y))
        context.drawPath(using: .fill)
        
        UIGraphicsPopContext()
    }
    
    // MARK: drawing instance methods
    
    /// Draw the circular slider
    internal func drawCircularSlider(inContext context: CGContext) {
        diskColor.setFill()
        trackColor.setStroke()
        
        
        let circle = Circle(origin: bounds.center, radius: self.radius)
        let sliderArc = Arc(circle: circle, startAngle: CircularSliderHelper.circleMinValue, endAngle: CircularSliderHelper.circleMaxValue)
        CircularSlider.drawArc(withArc: sliderArc, lineWidth: lineWidth, inContext: context)
    }
    
    /// draw Filled arc between start an end angles
    internal func drawFilledArc(fromAngle startAngle: CGFloat, toAngle endAngle: CGFloat, inContext context: CGContext) {
        diskFillColor.setFill()
        trackFillColor.setStroke()
        
        let circle = Circle(origin: bounds.center, radius: self.radius)
        let arc = Arc(circle: circle, startAngle: startAngle, endAngle: endAngle)
        
        // fill Arc
        CircularSlider.drawDisk(withArc: arc, inContext: context)
        // stroke Arc
        var B=UIColor(red:0.00, green:0.72, blue:0.83, alpha:1.0)
        var A=UIColor(red:0.00, green:0.90, blue:1.00, alpha:1.0)
        var E=[A,B]
        CircularSlider.DRAWArc(context, center: CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5), radius: circle.radius, lineWidth: lineWidth, fromAngleFromNorth: startAngle, toAngleFromNorth: endAngle, lineCap: CGLineCap.butt, colors: E)
        //CircularSlider.DRAWArc(withArc: arc, lineWidth: lineWidth, mode: .stroke, inContext: context)
    }
    
    
    /**
     Draw the thumb and return the coordinates of its center
     
     - parameter angle:   the angle of the point in the main circle
     - parameter context: the context
     
     - returns: return the origin point of the thumb
     */
    @discardableResult
    internal func drawThumb(withAngle angle: CGFloat, inContext context: CGContext) -> CGPoint {
        let circle = Circle(origin: bounds.center, radius: self.radius)
        let thumbOrigin = CircularSliderHelper.endPoint(fromCircle: circle, angle: angle)
        let thumbCircle = Circle(origin: thumbOrigin, radius: thumbRadius)
        let thumbArc = Arc(circle: thumbCircle, startAngle: CircularSliderHelper.circleMinValue, endAngle: CircularSliderHelper.circleMaxValue)
        
        CircularSlider.drawArc(withArc: thumbArc, lineWidth: thumbLineWidth, inContext: context)
        return thumbOrigin
    }
    
    
    /**
     Draw thumb using image and return the coordinates of its center
     
     - parameter image:   the image of the thumb
     - parameter angle:   the angle of the point in the main circle
     - parameter context: the context
     
     - returns: return the origin point of the thumb
     */
    @discardableResult
    internal func drawThumb(withImage image: UIImage, angle: CGFloat, inContext context: CGContext) -> CGPoint  {
        UIGraphicsPushContext(context)
        context.beginPath()
        let circle = Circle(origin: bounds.center, radius: self.radius)
        let thumbOrigin = CircularSliderHelper.endPoint(fromCircle: circle, angle: angle)
        let imageSize = image.size
        let imageFrame = CGRect(x: thumbOrigin.x - (imageSize.width / 2), y: thumbOrigin.y - (imageSize.height / 2), width: imageSize.width, height: imageSize.height)
        
        image.draw(in: imageFrame)
        UIGraphicsPopContext()
        
        return thumbOrigin
    }
}
