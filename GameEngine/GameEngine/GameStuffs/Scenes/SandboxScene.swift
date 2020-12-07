//
//  SandboxScene.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/20.
//

import MetalKit


class SandboxScene: Scene {
    
    var debugCamera = DebugCamera()
    var quad = Quad()
    
    override func buildScene() {
        addCamera(debugCamera)
        debugCamera.setPositionZ(5)
        quad.setTexture(.IMG)
        addChild(quad)
    }
    
    override func doUpdate() {
        quad.rotateY(GameTime.DeltaTime)
    }
}
