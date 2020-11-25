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

        engine.renderer.mtkView(mtkView, drawableSizeWillChange: mtkView.drawableSize)
    }
}
