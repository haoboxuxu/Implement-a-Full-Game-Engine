//
//  DebugCamera.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/21.
//

import simd

class DebugCamera: Camera {
    var cameraTypes: CameraTypes = CameraTypes.Debug
    var position: float3 = float3(0)
    
    var projectionMatrix: matrix_float4x4 {
        return matrix_float4x4.perspective(degreesFov: 45, aspectRatio: Renderer.AspectRatio, near: 0.1, far: 1000)
    }
    
    func update(deltaTime: Float) {
        if (Keyboard.ISKeyPressed(.leftArrow)) {
            self.position.x -= deltaTime
        }
        
        if (Keyboard.ISKeyPressed(.rightArrow)) {
            self.position.x += deltaTime
        }
        
        if (Keyboard.ISKeyPressed(.upArrow)) {
            self.position.y += deltaTime
        }
        
        if (Keyboard.ISKeyPressed(.downArrow)) {
            self.position.y -= deltaTime
        }
    }
}
