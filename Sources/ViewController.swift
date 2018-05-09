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
    weak var blueTimer: Timer?
    weak var redTimer: Timer?

    @IBAction func shoot(_ sender: NSButton) {
        blueProjectile.position = .zero
        blueProjectile.velocity = CGVector(dx: vxBlueTextField.doubleValue, dy: vyBlueTextField.doubleValue)
        blueProjectile.acceleration = CGVector(dx: axBlueTextField.doubleValue, dy: ayBlueTextField.doubleValue)
        
        blueTimer = Timer.scheduledTimer(timeInterval: updateInterval, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        blueHasBeenShot = true
    }
    
    
    @IBAction func shootRed(_ sender: NSButton) {
        redProjectile.position = .zero
        redProjectile.velocity = CGVector(dx: vxBlueTextField.doubleValue, dy: vyBlueTextField.doubleValue)
        redProjectile.acceleration = CGVector(dx: axBlueTextField.doubleValue, dy: ayBlueTextField.doubleValue)
        
        redTimer = Timer.scheduledTimer(timeInterval: updateInterval, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        redHasBeenShot = true
    }
    
    /// Perform an update by stepping the physics forward.
    @objc func update() {
        
        canvas.canvasDelegate = self

        let date = Date()
        let Δt = date.timeIntervalSince(lastUpdate)
        lastUpdate = date
        
        if Δt > 0.5 {
            // Avoid big time gaps
            return
        }
    
        updateRed(t:Δt)
        updateBlue(t:Δt)
    }
    
    /// Perform an update by stepping the physics forward.
    @objc func updateRed(t: TimeInterval) {

        redProjectile.step(Δt: CGFloat(t))
        canvas.redProjectile = redProjectile
        
        if !canvas.bounds.contains(redProjectile.position) {
            blueTimer?.invalidate()
        }
    }
    
    /// Perform an update by stepping the physics forward.
    @objc func updateBlue(t: TimeInterval) {
    
        blueProjectile.step(Δt: CGFloat(t))
        canvas.blueProjectile = blueProjectile
        
        if !canvas.bounds.contains(blueProjectile.position) {
            redTimer?.invalidate()
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
            self.blueProjectile.velocity = CGVector.zero
            self.blueProjectile.acceleration = CGVector(dx: 0, dy: -10)
            
            self.redProjectile.position = CGPoint.zero
            self.redProjectile.velocity = CGVector.zero
            self.redProjectile.acceleration = CGVector(dx: 0, dy: -10)
            
            self.redTimer?.invalidate()
            self.blueTimer?.invalidate()
  
        })
    }
}
