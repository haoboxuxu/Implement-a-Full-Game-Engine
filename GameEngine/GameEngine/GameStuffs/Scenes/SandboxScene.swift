//
//  SandboxScene.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/20.
//

import MetalKit


class SandboxScene: Scene {
    
    var debugCamera = DebugCamera()
    
    override func buildScene() {
        
        
        addCamera(debugCamera)
        debugCamera.position.z = 40
        addCubes()
        
    }
    
    var cubeCollection1: CubeCollection!
    func addCubes() {
        /*
        for y in -3..<4 {
            let posY = Float(y) + 0.5
            for x in -3..<4 {
                let posX = Float(x) + 0.5
                for z in -3..<4 {
                    let posZ = Float(z) + 0.5
                    let cube = Cube()
                    cube.position.x = posX
                    cube.position.y = posY
                    cube.position.z = posZ
                    cube.scale = float3(0.2)
                    cube.setColor(ColorUtil.randomColor)
                    addChild(cube)
                }
            }
        }*/
        
        cubeCollection1 = CubeCollection(cubesWide: 7, cubesHigh: 7, cubesBack: 7)
        addChild(cubeCollection1)
    }
    
    override func update(deltaTime: Float) {
        cubeCollection1.rotation.z += deltaTime
        super.update(deltaTime: deltaTime)
    }
}
