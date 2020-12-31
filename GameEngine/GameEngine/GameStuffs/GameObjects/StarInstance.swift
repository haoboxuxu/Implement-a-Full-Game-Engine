//
//  StarInstance.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/31.
//

import MetalKit

class StarInstance: Node {
    init(starCount: Int) {
        super.init(name: "Stars")
        
        let stars = InstanceGameObject(meshType: .Sphere, instanceCount: starCount)
        stars.updateNodes(updateTreePosition)
        addChild(stars)
    }
    
    private func updateTreePosition(star: Node, i: Int) {
        
        star.setScale(0.1)
        let pos = float3(Float.random(in: -100...100), Float.random(in: 0...200), Float.random(in: -100...100))
        star.setPosition(pos)
    }
}

