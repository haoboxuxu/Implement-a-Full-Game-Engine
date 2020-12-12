//
//  Sun.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/12.
//

import MetalKit

class Sun: LightObject {
    init() {
        super.init(meshType: .Sphere, name: "Sun")
        self.setColor(float4(0.5, 0.5, 0, 1))
        self.setScale(0.5)
    }
}
