//  Copyright © 2017 JABT. All rights reserved.

import Cocoa

class ViewController: NSViewController {
    /// How often to execute an update.
    let updateInterval = 1 / 60 as TimeInterval

    @IBOutlet weak var vxTextField: NSTextField!
    @IBOutlet weak var vyTextField: NSTextField!
    @IBOutlet weak var axTextField: NSTextField!
    @IBOutlet weak var ayTextField: NSTextField!
    @IBOutlet weak var canvas: Canvas!

    /// The model object representing the projectile.
    var projectile = Projectile()

    /// Last time we did an update.
    var lastUpdate = Date.distantPast

    /// Update timer.
    weak var timer: Timer?

    @IBAction func shoot(_ sender: NSButton) {
        projectile.position = .zero
        projectile.velocity = CGVector(dx: vxTextField.doubleValue, dy: vyTextField.doubleValue)
        projectile.acceleration = CGVector(dx: axTextField.doubleValue, dy: ayTextField.doubleValue)
        
        timer = Timer.scheduledTimer(timeInterval: updateInterval, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }

    /// Perform an update by stepping the physics forward.
    @objc func update() {
        let date = Date()
        let Δt = date.timeIntervalSince(lastUpdate)
        lastUpdate = date

        if Δt > 0.5 {
            // Avoid big time gaps
            return
        }
        projectile.step(Δt: CGFloat(Δt))
        canvas.projectile = projectile

        if !canvas.bounds.contains(projectile.position) {
            timer?.invalidate()
        }
    }
}
