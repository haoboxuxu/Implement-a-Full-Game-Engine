//
//  terrain.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/29.
//

import Foundation

class Terrain: GameObject {
    init() {
        super.init(name: "terrain", meshType: .Quad)
        setRotationX(Float(90).toRadians)
        let color = float4(0.3, 0.3, 0.3, 1.0)
        var material = Material()
        material.color = color
        material.isLit = false
        // useMaterial(material)
        useBaseColorTexture(.moon_terrian)
        setScale(80)
    }
}
