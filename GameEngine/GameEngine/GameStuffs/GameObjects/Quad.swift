//
//  Quad.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/4.
//

import simd

class Quad: GameObject {
    init() {
        super.init(meshType: .Quad_Custom)
        self.setName("Quda")
    }
}
