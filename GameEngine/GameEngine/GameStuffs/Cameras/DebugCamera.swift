//
//  DebugCamera.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/21.
//

import simd

class DebugCamera: Camera {
    
    private var _moveSpeed: Float = 4.0
    private var _turnSpeed: Float = 0.5
    
    private var _projectionMatrix = matrix_identity_float4x4
    
    override var projectionMatrix: matrix_float4x4 {
        return _projectionMatrix
    }
    
    init() {
        super.init(name: "Debug", cameraType: .Debug)
        _projectionMatrix = matrix_float4x4.perspective(degreesFov: 45.0, aspectRatio: Renderer.AspectRatio, near: 0.1, far: 1000)
    }
    
    override func doUpdate() {
        if Keyboard.ISKeyPressed(.leftArrow) {
            self.moveX(-GameTime.DeltaTime * _moveSpeed)
        }
        
        if Keyboard.ISKeyPressed(.rightArrow) {
            self.moveX(GameTime.DeltaTime * _moveSpeed)
        }
        
        if Keyboard.ISKeyPressed(.upArrow) {
            self.moveY(GameTime.DeltaTime * _moveSpeed)
        }
        
        if Keyboard.ISKeyPressed(.downArrow) {
            self.moveY(-GameTime.DeltaTime * _moveSpeed)
        }
        
        if Mouse.IsMouseButtonPressed(button: .right) {
            self.rotate(Mouse.GetDY() * GameTime.DeltaTime * _turnSpeed, Mouse.GetDX() * GameTime.DeltaTime * _turnSpeed, 0)
        }
        
        if Mouse.IsMouseButtonPressed(button: .center) {
            self.moveX(-Mouse.GetDX() * GameTime.DeltaTime * _moveSpeed)
            self.moveY(Mouse.GetDY() * GameTime.DeltaTime * _moveSpeed)
        }
        
        self.moveZ(-Mouse.GetDWheel() * 0.1)
    }
}
