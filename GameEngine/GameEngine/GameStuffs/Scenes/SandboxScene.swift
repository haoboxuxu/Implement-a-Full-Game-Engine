//
//  SandboxScene.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/20.
//

import MetalKit


class SandboxScene: Scene {
    
    var debugCamera = DebugCamera()
    var quad = Quad()
    var sun = Sun()
    
     // Phong Shadering
    var cruiser = Cruiser()
    var leftSun = Sun()
    var rightSun = Sun()
    var middleSun = Sun()
    
    
    
    override func buildScene() {
        debugCamera.setPosition(float3(0, 0, 4))
        addCamera(debugCamera)
        
        
         // Phong Shadering
        leftSun.setPosition(float3(-1, 1, 0))
        leftSun.setMaterialIsLit(false)
        leftSun.setMaterialColor(float4(1, 0, 0, 1))
        leftSun.setLightColor(float3(1, 0, 0))
        addLight(leftSun)
        
        middleSun.setPosition(float3(0, 1, 0))
        middleSun.setMaterialIsLit(false)
        middleSun.setLightBrightness(0.3)
        middleSun.setMaterialColor(float4(1, 1, 1, 1))
        middleSun.setLightColor(float3(1, 1, 1))
        addLight(middleSun)
        
        rightSun.setPosition(float3(1, 1, 0))
        rightSun.setMaterialIsLit(false)
        rightSun.setMaterialColor(float4(0, 0, 1, 1))
        rightSun.setLightColor(float3(0, 0, 1))
        addLight(rightSun)
        
        cruiser.setMaterialAmbient(0.01)
        cruiser.setRotationX(0.3)
        addChild(cruiser)
        
        
        sun.setPosition(float3(0, 1, 1))
        sun.setMaterialIsLit(false)
        sun.setLightBrightness(0.9)
        sun.setMaterialColor(1, 1, 1, 1)
        sun.setLightColor(1, 1, 1)
        addLight(sun)
        
        quad.setMaterialAmbient(0.3)
        quad.setMaterialShininess(10)
        quad.setMaterialSpecular(5)
        quad.setTexture(.IMG)
        addChild(quad)
    }
    
    override func doUpdate() {
        
        if (Mouse.IsMouseButtonPressed(button: .left)) {
            let xxx = Mouse.GetDY() * GameTime.DeltaTime
            let yyy = Mouse.GetDX() * GameTime.DeltaTime
            cruiser.rotateX(xxx)
            cruiser.rotateY(yyy)
            quad.rotateX(xxx)
            quad.rotateY(yyy)
        }
        /* // Phong Shadering
        leftSun.setPositionX(cos(GameTime.TotalGameTime) - 1)
        middleSun.setPositionX(cos(GameTime.TotalGameTime))
        rightSun.setPositionX(cos(GameTime.TotalGameTime) + 1)
        cruiser.setMaterialShininess(max(cruiser.getMaterialShininess() + Mouse.GetDWheel(), 0))
        */
        //sun.setPositionX(cos(GameTime.TotalGameTime))
    }
}
