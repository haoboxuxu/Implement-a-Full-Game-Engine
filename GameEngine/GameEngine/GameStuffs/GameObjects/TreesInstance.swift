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
