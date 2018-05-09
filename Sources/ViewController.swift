//  Copyright © 2017 JABT. All rights reserved.

import Cocoa

public var blueHasBeenShot: Bool?
public var redHasBeenShot: Bool?

class ViewController: NSViewController, CanvasDelegate {
    
    /// How often to execute an update.
    let updateInterval = 1 / 60 as TimeInterval

    @IBOutlet weak var vxBlueTextField: NSTextField!
    @IBOutlet weak var vyBlueTextField: NSTextField!
    @IBOutlet weak var axBlueTextField: NSTextField!
    @IBOutlet weak var ayBlueTextField: NSTextField!
    
    @IBOutlet weak var vxRedTextField: NSTextField!
    @IBOutlet weak var vyRedTextField: NSTextField!
    @IBOutlet weak var axRedTextField: NSTextField!
    @IBOutlet weak var ayRedTextField: NSTextField!
    
    
    
    @IBOutlet weak var canvas: Canvas!

    /// The models object representing the projectiles.
    var blueProjectile = Projectile()
    var redProjectile = Projectile()

    /// Last time we did an update.
    var lastUpdate = Date.distantPast

    /// Update timer.
    weak var timer: Timer?

    @IBAction func shoot(_ sender: NSButton) {
        blueProjectile.position = .zero
        blueProjectile.velocity = CGVector(dx: vxBlueTextField.doubleValue, dy: vyBlueTextField.doubleValue)
        blueProjectile.acceleration = CGVector(dx: axBlueTextField.doubleValue, dy: ayBlueTextField.doubleValue)
        
        timer = Timer.scheduledTimer(timeInterval: updateInterval, target: self, selector: #selector(updateBlue), userInfo: nil, repeats: true)
        
        blueHasBeenShot = true
    }
    
    
    @IBAction func shootRed(_ sender: NSButton) {
        redProjectile.position = .zero
        redProjectile.velocity = CGVector(dx: vxBlueTextField.doubleValue, dy: vyBlueTextField.doubleValue)
        redProjectile.acceleration = CGVector(dx: axBlueTextField.doubleValue, dy: ayBlueTextField.doubleValue)
        
        timer = Timer.scheduledTimer(timeInterval: updateInterval, target: self, selector: #selector(updateBlue), userInfo: nil, repeats: true)
        
        redHasBeenShot = true
    }
    
    /// Perform an update by stepping the physics forward.
    @objc func updateBlue() {
        
        canvas.canvasDelegate = self
        
        let date = Date()
        let Δt = date.timeIntervalSince(lastUpdate)
        lastUpdate = date

        if Δt > 0.5 {
            // Avoid big time gaps
            return
        }
        
        blueProjectile.step(Δt: CGFloat(Δt))
        canvas.blueProjectile = blueProjectile

        if !canvas.bounds.contains(blueProjectile.position) {
            timer?.invalidate()
        }
        
        redProjectile.step(Δt: CGFloat(Δt))
        canvas.redProjectile = redProjectile
        
        if !canvas.bounds.contains(redProjectile.position) {
            timer?.invalidate()
        }
        
        
    }
    
    @objc func updateRed() {
        let date = Date()
        let Δt = date.timeIntervalSince(lastUpdate)
        lastUpdate = date
        
        if Δt > 0.5 {
            // Avoid big time gaps
            return
        }
        
        
        redProjectile.step(Δt: CGFloat(Δt))
        canvas.redProjectile = redProjectile
        
        if !canvas.bounds.contains(redProjectile.position) {
            timer?.invalidate()
        }
    }
    
    func presentCollisionAlert(){
        let alert = NSAlert()
        alert.messageText = "BANG!"
        alert.informativeText = "The projectiles collided"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK, Restart")
   
        alert.beginSheetModal(for: self.view.window!, completionHandler: {(response) in
            
            //restart 
            self.blueProjectile.position = CGPoint.zero
            self.redProjectile.position = CGPoint.zero
  
        })
    }
}
