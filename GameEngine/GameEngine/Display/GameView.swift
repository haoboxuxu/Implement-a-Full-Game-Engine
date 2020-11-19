//
//  GameView.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/18.
//

import MetalKit

class GameView: MTKView {
    
    var renderer: Renderer!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.device = MTLCreateSystemDefaultDevice()
        Engine.Ignite(device: device!)
        
        self.clearColor = Prefences.clearColor
        self.colorPixelFormat = Prefences.MainPixelFormat
        
        self.renderer = Renderer()
        
        self.delegate = renderer
    }
}
