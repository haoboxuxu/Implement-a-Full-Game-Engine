//
//  Player.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/19.
//

import MetalKit

class Player: GameObject {
    init() {
        super.init(meshType: .Triangle_Custom)
    }
    
    override func update(deltaTime: Float) {
        self.rotation.z = -atan2(Mouse.GetMouseViewportPosition().x - position.x, Mouse.GetMouseViewportPosition().y - position.y)
        super.update(deltaTime: deltaTime)
    }
}
