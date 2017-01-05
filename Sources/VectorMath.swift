//  Copyright © 2017 JABT. All rights reserved.

import Foundation

func + (lhs: CGVector, rhs: CGVector) -> CGVector {
    return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
}

func + (lhs: CGPoint, rhs: CGVector) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy)
}

func - (lhs: CGVector, rhs: CGVector) -> CGVector {
    return CGVector(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy)
}

func - (lhs: CGPoint, rhs: CGVector) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.dx, y: lhs.y - rhs.dy)
}

func += (lhs: inout CGVector, rhs: CGVector) {
    lhs.dx += rhs.dx
    lhs.dy += rhs.dy
}

func += (lhs: inout CGPoint, rhs: CGVector) {
    lhs.x += rhs.dx
    lhs.y += rhs.dy
}

func -= (lhs: inout CGVector, rhs: CGVector) {
    lhs.dx -= rhs.dx
    lhs.dy -= rhs.dy
}

func -= (lhs: inout CGPoint, rhs: CGVector) {
    lhs.x -= rhs.dx
    lhs.y -= rhs.dy
}

func * (lhs: CGFloat, rhs: CGVector) -> CGVector {
    return CGVector(dx: lhs * rhs.dx, dy: lhs * rhs.dy)
}

func * (lhs: CGVector, rhs: CGFloat) -> CGVector {
    return CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
}

func *= (lhs: inout CGVector, rhs: CGFloat) {
    lhs.dx *= rhs
    lhs.dy *= rhs
}
