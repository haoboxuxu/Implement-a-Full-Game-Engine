//
//  Trees.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/31.
//

import MetalKit

class TreesInstance: Node {
    init(treeDecoratedCount: Int, treePineSnowCount: Int, treePineSnowedCount: Int) {
        super.init(name: "Trees")
        
        let treeDecorated = InstanceGameObject(meshType: .treeDecorated, instanceCount: treeDecoratedCount)
        treeDecorated.updateNodes(updateTreePosition)
        addChild(treeDecorated)
        
        let treePineSnow = InstanceGameObject(meshType: .treePineSnow, instanceCount: treePineSnowCount)
        treePineSnow.updateNodes(updateTreePosition)
        addChild(treePineSnow)
        
        let treePineSnowed = InstanceGameObject(meshType: .treePineSnowed, instanceCount: treePineSnowedCount)
        treePineSnowed.updateNodes(updateTreePosition)
        addChild(treePineSnowed)
    }
    
    private func updateTreePosition(tree: Node, i: Int) {
        let radius: Float = Float.random(in: 8...70)
        let pos = float3(cos(Float(i)) * radius,
                         0,
                         sin(Float(i)) * radius)
        tree.setPosition(pos)
        tree.setScale(Float.random(in: 1...2))
        tree.rotateY(Float.random(in: 0...360))
    }
}

class PresentInstance: Node {
    init(presentCount: Int, presentGreenCount: Int) {
        super.init(name: "Presents")
        
        let present = InstanceGameObject(meshType: .present, instanceCount: presentCount)
        present.updateNodes(updatePresentPosition)
        addChild(present)
        
        let presentGreen = InstanceGameObject(meshType: .presentGreen, instanceCount: presentGreenCount)
        presentGreen.updateNodes(updatePresentPosition)
        addChild(presentGreen)
    }
    
    private func updatePresentPosition(present: Node, i: Int) {
        let radius: Float = Float.random(in: 8...70)
        let pos = float3(cos(Float(i)) * radius,
                         0,
                         sin(Float(i)) * radius)
        present.setPosition(pos)
        present.setScale(Float.random(in: 1...2))
        present.rotateY(Float.random(in: 0...360))
    }
}

class SnowmenInstance: Node {
    init(snowmanCount: Int, snowmanFancyCount: Int) {
        super.init(name: "Presents")
        
        let snowman = InstanceGameObject(meshType: .snowman, instanceCount: snowmanCount)
        snowman.updateNodes(updateSnowmenPosition)
        addChild(snowman)
        
        let snowmanFancy = InstanceGameObject(meshType: .snowmanFancy, instanceCount: snowmanFancyCount)
        snowmanFancy.updateNodes(updateSnowmenPosition)
        addChild(snowmanFancy)
    }
    
    private func updateSnowmenPosition(snowman: Node, i: Int) {
        let radius: Float = Float.random(in: 8...70)
        let pos = float3(cos(Float(i)) * radius,
                         0,
                         sin(Float(i)) * radius)
        snowman.setPosition(pos)
        snowman.setScale(Float.random(in: 1...2))
        snowman.rotateY(Float.random(in: 0...360))
    }
}

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
