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
    
    override func doUpdate() {
        self.rotateX(GameTime.DeltaTime)
        self.rotateY(GameTime.DeltaTime)
    }
}

