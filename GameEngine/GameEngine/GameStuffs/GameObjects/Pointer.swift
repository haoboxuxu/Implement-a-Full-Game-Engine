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
        super.init(name: "Pointer", meshType: .Triangle_Custom)
        self.camera = camera
        self.setName("Pointer")
    }
    
    override func doUpdate() {
        self.rotateZ(-atan2f(Mouse.GetMouseViewportPosition().x - getPositionX() + camera.getPositionX(),
                             Mouse.GetMouseViewportPosition().y - getPositionY() + camera.getPositionY()))
    }
}
