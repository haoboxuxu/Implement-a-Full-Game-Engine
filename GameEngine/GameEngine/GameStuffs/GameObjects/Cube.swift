//
//  Cube.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/21.
//

import MetalKit

class Cube: GameObject {
    init() {
        super.init(meshType: .Cube_Custom)
    }
    
    override func update(deltaTime: Float) {
        self.rotation.x += (deltaTime * Float.randomZeroToOne)
        self.rotation.y += (deltaTime * Float.randomZeroToOne)
        super.update(deltaTime: deltaTime)
    }
}

