//  Copyright © 2017 JABT. All rights reserved.

import Cocoa
import QuartzCore

protocol CanvasDelegate {
    func presentCollisionAlert()
}

/// A view that draws a projectile as a circle.
class Canvas: NSView {
    /// The projectile color.
    let blueProjectileColor = NSColor.blue
    let redProjectileColor = NSColor.red
    
    var canvasDelegate: CanvasDelegate!

    /// The projectile to draw.
    var blueProjectile = Projectile() {
        didSet {
            setNeedsDisplay(bounds)
        }
    }
    
    var redProjectile = Projectile() {
        didSet {
            setNeedsDisplay(bounds)
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        let blueRect = CGRect(x: blueProjectile.position.x - blueProjectile.radius, y: blueProjectile.position.y - blueProjectile.radius, width: 2*blueProjectile.radius, height: 2*blueProjectile.radius)
        let bluePath = NSBezierPath(ovalIn: blueRect)

        blueProjectileColor.setFill()
        bluePath.fill()
        
        
        let redRect = CGRect(x: redProjectile.position.x - redProjectile.radius, y: redProjectile.position.y - redProjectile.radius, width: 2*redProjectile.radius, height: 2*redProjectile.radius)
        let redPath = NSBezierPath(ovalIn: redRect)
        
        redProjectileColor.setFill()
        redPath.fill()
        
        
        if let blueWasShot = blueHasBeenShot, blueWasShot == true {
            
            if let redWasShot = redHasBeenShot, redWasShot == true {
                
                blueHasBeenShot = false
                redHasBeenShot = false
        
            //collision detection
            if (redRect.intersects(blueRect)){
                canvasDelegate.presentCollisionAlert()
            }
            }
        }
    }
    
}
