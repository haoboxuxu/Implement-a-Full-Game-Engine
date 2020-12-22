//
//  DebugCamera.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/21.
//

import simd

class DebugCamera: Camera {
    
    override var projectionMatrix: matrix_float4x4 {
        return matrix_float4x4.perspective(degreesFov: 45.0, aspectRatio: Renderer.AspectRatio, near: 0.1, far: 1000)
    }
    
    init() {
        super.init(name: "Debug", cameraType: .Debug)
    }
    
    override func doUpdate() {
        if Keyboard.ISKeyPressed(.leftArrow) {
            self.moveX(-GameTime.DeltaTime)
        }
        
        if Keyboard.ISKeyPressed(.rightArrow) {
            self.moveX(GameTime.DeltaTime)
        }
        
        if Keyboard.ISKeyPressed(.upArrow) {
            self.moveY(GameTime.DeltaTime)
        }
        
        if Keyboard.ISKeyPressed(.downArrow) {
            self.moveY(-GameTime.DeltaTime)
        }
        
        if Mouse.IsMouseButtonPressed(button: .right) {
            self.rotate(Mouse.GetDY() * GameTime.DeltaTime * 0.1, Mouse.GetDX() * GameTime.DeltaTime * 0.1, 0)
        }
        
        if Mouse.IsMouseButtonPressed(button: .center) {
            self.moveX(-Mouse.GetDX() * GameTime.DeltaTime)
            self.moveY(Mouse.GetDY() * GameTime.DeltaTime)
        }
        
        self.moveZ(-Mouse.GetDWheel() * 0.1)
    }
}
