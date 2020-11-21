//
//  Player.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/19.
//

import MetalKit

class Pointer: GameObject {
    
    private var camera: Camera!
    
    init(camera: Camera) {
        super.init(meshType: .Triangle_Custom)
        self.camera = camera
    }
    
    override func update(deltaTime: Float) {
        self.rotation.z = -atan2(Mouse.GetMouseViewportPosition().x - position.x + camera.position.x,
                                 Mouse.GetMouseViewportPosition().y - position.y + camera.position.y)
        super.update(deltaTime: deltaTime)
    }
}
