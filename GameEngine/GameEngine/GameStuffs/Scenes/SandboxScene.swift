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
    var sun = Sun()


    override func buildScene() {
        debugCamera.setPosition(float3(0, 0, 3))
        addCamera(debugCamera)
        
        sun.setPosition(float3(0, 5, 5))
        sun.setLightAmbientIntensity(0.1)
        addLight(sun)
        
        addChild(quad)
    }

    override func doUpdate() {
        if (Mouse.IsMouseButtonPressed(button: .left)) {
            quad.rotate(Mouse.GetDY() * GameTime.DeltaTime, Mouse.GetDX() * GameTime.DeltaTime, 0)
        }
    }
}

