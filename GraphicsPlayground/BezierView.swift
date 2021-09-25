//
//  BezierView.swift
//  GraphicsPlayground
//
//  Created by Tobias Helsing on 25.9.2021.
//  Inspired by coding train video: https://www.youtube.com/watch?v=enNfb6p3j_g
//  https://en.wikipedia.org/wiki/B%C3%A9zier_curve

import SwiftUI


struct BezierView: View {
    var screenSize = UIScreen.main.bounds.size
    var p0: CGPoint
    var p1: CGPoint
    var p2: CGPoint
    var p3: CGPoint
    
    init() {
        p0 = CGPoint(x: 0, y: screenSize.height / 2)
        p1 = CGPoint(x: screenSize.width * 0.3, y: 0)
        p2 = CGPoint(x: screenSize.width * 0.7, y: screenSize.height)
        p3 = CGPoint(x: screenSize.width, y: screenSize.height / 2)
    }
    
    
    
    var body: some View {
        GeometryReader {_ in
            CustomPath().stroke()
        }
    }
    
    
    func CustomPath() -> Path {
        var path = Path()
    
        path.move(to: p0)
        
//        var lastPos: CGPoint? = nil;
        
        for t in stride(from: CGFloat(0), to: CGFloat(1.1), by: CGFloat(0.1)) {
            // how far between point 0 to 1,
            let a = lerp(p0: p0, p1: p1, t: t)
            // how far between point 1 to 2,
            let b = lerp(p0: p1, p1: p2, t: t)
            // lerped "hill" and set to be actual point
            // think of lerp between 3 points to draw the curve.
            let pointA = lerp(p0: a, p1: b, t: t)
            
            let c = lerp(p0: p1, p1: p2, t: t)
            let d = lerp(p0: p2, p1: p3, t: t)
            let pointB = lerp(p0: c, p1: d, t: t)
                
    
            // Broken atm
//            path.move(to: a)
//            path.addLine(to: b)
//
//            if (lastPos != nil) {
//                path.move(to: lastPos!)
//            }
                
            path.addLine(to: lerp(p0: pointA, p1: pointB, t: t))
//            lastPos = lerp(p0: pointA, p1: pointB, t: t)
        }
        
        
        return path
    }
    
    func lerp(p0: CGPoint, p1: CGPoint, t: CGFloat) -> CGPoint {
        let x = p0.x + (p1.x - p0.x) * t
        let y = p0.y + (p1.y - p0.y) * t
        return CGPoint(x: x, y: y)
    }
}

struct BezierView_Previews: PreviewProvider {
    static var previews: some View {
        BezierView()
    }
}

