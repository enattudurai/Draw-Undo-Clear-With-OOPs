//
//  Cavas.swift
//  Draw-Undo
//
//  Created by Naattudurai Eswaramurthy on 25/02/19.
//  Copyright © 2019 Naattudurai Eswaramurthy. All rights reserved.
//

import UIKit



class Canvas : UIView
{

    //Keep track of the points
    fileprivate var lines = [Line]()
    
    fileprivate var stokeColor: UIColor = .black
    fileprivate var stokeWidth: CGFloat = 1
    
    //Public Method
    func setStokeColor(color : UIColor)  {
        stokeColor = color
    }
    
    func setStokeWidth(width : CGFloat)  {
        stokeWidth = width
    }
    
    func Undo()  {
        
        _ = lines.popLast()
        setNeedsDisplay()
        
    }
    
    func Clear()  {
        
        lines.removeAll()
        setNeedsDisplay()
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let currentContext = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //Set current Contest info like Color, line width, etc..
        
        
        lines.forEach { (line) in
            
            currentContext.setStrokeColor(line.color.cgColor)
            currentContext.setLineWidth(line.width)
            currentContext.setLineCap(.butt)
            for(index, point) in line.points.enumerated()
            {
                if index == 0
                {
                    currentContext.move(to: point) // Move to the Starting position
                }
                else
                {
                    currentContext.addLine(to: point) // Add line from the previous position
                }
            }
            currentContext.strokePath()
        }
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        lines.append(Line.init(color: stokeColor, width: stokeWidth, points: [CGPoint]()))
        //Start the new point when Touches begin
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: nil) else {
            return
        }
        
        //Adding point to the current moves
        guard var lastPoint = lines.popLast() else { return }
        lastPoint.points.append(point)
        lines.append(lastPoint)
        setNeedsDisplay()

    }
    
}
