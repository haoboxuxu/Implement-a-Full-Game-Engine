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
    var quda2 = Quad()
    var sun = Sun()


    override func buildScene() {
        debugCamera.setPosition(float3(0, 0, 3))
        addCamera(debugCamera)
        
        sun.setPosition(float3(0, 5, 5))
        sun.setLightAmbientIntensity(0.1)
        addLight(sun)
        
        quad.useBaseColorTexture(.MetalPlateDiffuse)
        quad.useNormalMapTexture(.MetalPlateNormal)
        addChild(quad)
        
//        quda2.useBaseColorTexture(.BreakingBad)
//        quda2.useNormalMapTexture(.None)
        quda2.moveX(-2)
        addChild(quda2)
    }

    override func doUpdate() {
        if (Mouse.IsMouseButtonPressed(button: .left)) {
            quad.rotate(Mouse.GetDY() * GameTime.DeltaTime, Mouse.GetDX() * GameTime.DeltaTime, 0)
        }
    }
}

