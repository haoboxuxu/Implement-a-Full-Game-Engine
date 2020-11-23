//
//  SandboxScene.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/20.
//

import MetalKit


class SandboxScene: Scene {
    
    var debugCamera = DebugCamera()
    
    //var cube = Cube()
    
    override func buildScene() {
        
        
        addCamera(debugCamera)
        debugCamera.position.z = 13
        addCubes()
        /*
        cube.setColor(float4(0.8, 0.7, 0.6, 1.0))
        
        let count: Int = 5
        for y in -count..<count {
            for x in -count..<count {
                var pointer = Pointer(camera: debugCamera)
                pointer.position.x = Float(Float(y) + 0.5) / Float(count)
                pointer.position.y = Float(Float(x) + 0.5) / Float(count)
                pointer.scale = float3(0.1)
                addChild(pointer)
            }
        }
        addChild(cube)
        */
        
    }
    
    func addCubes() {
        for y in -5..<5 {
            let posY = Float(y) + 0.5
            for x in -8..<8 {
                let posX = Float(x) + 0.5
                let cube = Cube()
                cube.position.x = posX
                cube.position.y = posY
                cube.scale = float3(0.2)
                cube.setColor(ColorUtil.randomColor)
                addChild(cube)
            }
        }
    }
    
    /*
    override func update(deltaTime: Float) {
        cube.rotation.x += deltaTime
        cube.rotation.y += deltaTime
        super.update(deltaTime: deltaTime)
    }
    */
}
