//
//  Cruiser.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/9.
//

import MetalKit

class Cruiser: GameObject {
    init() {
        super.init(meshType: .Cruiser)
        setName("Cruiser")
        setTexture(.Cruiser)
    }
}
