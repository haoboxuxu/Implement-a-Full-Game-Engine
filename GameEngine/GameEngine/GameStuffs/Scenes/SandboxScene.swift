//
//  SandboxScene.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/20.
//

import MetalKit


class SandboxScene: Scene {
    
    var debugCamera = DebugCamera()
    var cruiser = Cruiser()
    
    override func buildScene() {
        addCamera(debugCamera)
        debugCamera.setPositionZ(5)
        addChild(cruiser)
    }
    
    override func doUpdate() {
        if (Mouse.IsMouseButtonPressed(button: .left)) {
            cruiser.rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            cruiser.rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
    }
}
