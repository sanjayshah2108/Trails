//  Copyright © 2017 JABT. All rights reserved.

import Cocoa
import QuartzCore

/// A view that draws a projectile as a circle.
class Canvas: NSView {
    /// The projectile color.
    let projectileColor = NSColor.blue

    /// The projectile to draw.
    var projectile = Projectile() {
        didSet {
            setNeedsDisplay(bounds)
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        let rect = CGRect(x: projectile.position.x - projectile.radius, y: projectile.position.y - projectile.radius, width: 2*projectile.radius, height: 2*projectile.radius)
        let path = NSBezierPath(ovalIn: rect)

        projectileColor.setFill()
        path.fill()
    }
    
}
