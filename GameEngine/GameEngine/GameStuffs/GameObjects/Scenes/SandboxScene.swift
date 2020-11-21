//
//  SandboxScene.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/20.
//

import MetalKit


class SandboxScene: Scene {
    
    var debugCamera = DebugCamera()
    
    override func buildScene() {
        
        addCamera(debugCamera)
        
        let count: Int = 5
        for y in -count..<count {
            for x in -count..<count {
                var pointer = Pointer(camera: debugCamera)
                pointer.position.x = Float(Float(y) + 0.5) / Float(count)
                pointer.position.y = Float(Float(x) + 0.5) / Float(count)
                pointer.scale = float3(0.1)
                addChild(pointer)
            }
        }
    }
    
    override func update(deltaTime: Float) {
        print(Mouse.GetMouseViewportPosition())
        super.update(deltaTime: deltaTime)
    }
}
