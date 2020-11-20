//
//  SandboxScene.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/20.
//

import MetalKit

class SandboxScene: Scene {
    
    override func buildScene() {
        let count: Int = 5
        for y in -count..<count {
            for x in -count..<count {
                var player = Player()
                player.position.x = Float(Float(y) + 0.5) / Float(count)
                player.position.y = Float(Float(x) + 0.5) / Float(count)
                player.scale = float3(0.1)
                addChild(player)
            }
        }
    }
    
    override func update(deltaTime: Float) {
        print(Mouse.GetMouseViewportPosition())
        super.update(deltaTime: deltaTime)
    }
}
