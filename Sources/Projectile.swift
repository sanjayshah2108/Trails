//  Copyright © 2017 JABT. All rights reserved.

import Foundation

/// Represents a physical object acted on by a constant acceleration.
struct Projectile {
    /// The radius.
    let radius = 20 as CGFloat

    /// The current location in space.
    var position = CGPoint.zero

    /// The current velocity.
    var velocity = CGVector.zero

    /// The projectile's acceleration.
    var acceleration = CGVector(dx: 0, dy: -10)

    /// Advance time by performing a simple numerical integration.
    mutating func step(Δt: CGFloat) {
        velocity += acceleration * Δt
        position += velocity * Δt
    }
}
