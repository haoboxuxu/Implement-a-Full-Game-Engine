//
//  UnRealScene.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/29.
//

import MetalKit

class UnRealScene: Scene {

    var debugCamera = DebugCamera()
    
    var sun = Sun()

    override func buildScene() {
        debugCamera.setPosition(float3(0, 1, 3))
        debugCamera.setRotationX(Float(10).toRadians)
        addCamera(debugCamera)
        
        sun.setPosition(float3(0, 100, 100))
        addLight(sun)
        
        //terrian
        let ter = terrain()
        //var presentGreen = GameObject(name: "presentGreen", meshType: .Quad)
        addChild(ter)
    }
}


