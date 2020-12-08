//
//  DebugCamera.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/21.
//

import simd

class DebugCamera: Camera {
    
    private var _zoom: Float = 45.0
    
    override var projectionMatrix: matrix_float4x4 {
        return matrix_float4x4.perspective(degreesFov: _zoom, aspectRatio: Renderer.AspectRatio, near: 0.1, far: 1000)
    }
    
    init() {
        super.init(cameraType: .Debug)
    }
    
    override func doUpdate() {
        if (Keyboard.ISKeyPressed(.leftArrow)) {
            self.moveX(-GameTime.DeltaTime)
        }
        
        if (Keyboard.ISKeyPressed(.rightArrow)) {
            self.moveX(GameTime.DeltaTime)
        }
        
        if (Keyboard.ISKeyPressed(.upArrow)) {
            self.moveY(GameTime.DeltaTime)
        }
        
        if (Keyboard.ISKeyPressed(.downArrow)) {
            self.moveY(-GameTime.DeltaTime)
        }
        
        self._zoom += Mouse.GetDWheel()
    }
}
