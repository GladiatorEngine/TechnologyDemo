//
//  GameViewController.swift
//  TechnologyDemo
//
//  Created by Pavel Kasila on 11/25/20.
//

import Cocoa
import MetalKit
import Engine

// Our macOS specific view controller
class GameViewController: NSViewController {

    var engine: Engine!
    var mtkView: MTKView!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let mtkView = self.view as? MTKView else {
            print("View attached to GameViewController is not an MTKView")
            return
        }

        // Select the device to render with.  We choose the default device
        guard let defaultDevice = MTLCreateSystemDefaultDevice() else {
            print("Metal is not supported on this device")
            return
        }

        mtkView.device = defaultDevice

        engine = Engine(mtkView: mtkView)
        engine.setupNetwork(host: "127.0.0.1", port: 8482)
        do {
            engine.logger.write(message: "Server: \(try engine.gameNetworkClient.greet(name: "TechnologyDemo"))", type: .info)
        } catch let e {
            engine.logger.write(message: "Failed to use GameNetwork: \(e)", type: .lowWarning)
        }
        
        // Load main asset pack
        do {
            try engine.assetManager.loadAssetPack(path: Bundle.main.path(forResource: "pack", ofType: "gea")!)
        } catch _ {
            fatalError("Cannot load AssetPack")
        }

        engine.renderer.mtkView(mtkView, drawableSizeWillChange: mtkView.drawableSize)
    }
}
