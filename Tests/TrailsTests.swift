//  Copyright © 2017 JABT. All rights reserved.

import XCTest
@testable import Trails

class TrailsTests: XCTestCase {
    func testUpdateProjectile() {
        var projectile = Projectile()
        projectile.velocity.dx = 10
        projectile.velocity.dy = 10
        projectile.acceleration.dx = 0
        projectile.acceleration.dy = 0
        projectile.step(Δt: 1)

        XCTAssertEqual(projectile.position.x, 10)
        XCTAssertEqual(projectile.position.y, 10)
    }
}
