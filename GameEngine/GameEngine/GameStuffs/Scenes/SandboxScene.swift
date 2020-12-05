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
        addChild(quad)
    }
    
    override func doUpdate() {
        quad.setPositionX(cos(GameTime.TotalGameTime))
        print(quad.getPosition())
    }
}
