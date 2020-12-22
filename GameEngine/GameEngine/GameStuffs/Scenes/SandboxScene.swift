//
//  SandboxScene.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/20.
//

import MetalKit


class SandboxScene: Scene {

    var debugCamera = DebugCamera()
    
    // mipmap
    var quad = Quad()

    // Phong Shadering
    var cruiser = Cruiser()
    var leftSun = Sun()
    var rightSun = Sun()
    var sun = Sun()
    
    // blender obj
    var chest = Chest()


    override func buildScene() {
        debugCamera.setPosition(float3(0, 0, 7))
        addCamera(debugCamera)
        
        addWhiteLight()
        
        addChild(chest)
    }

    override func doUpdate() {
        if (Mouse.IsMouseButtonPressed(button: .left)) {
            chest.rotate(Mouse.GetDY() * GameTime.DeltaTime, Mouse.GetDX() * GameTime.DeltaTime, 0)
        }
    }
    
    func addWhiteLight() {
        sun.setPosition(float3(0, 1, 10))
        sun.setMaterialIsLit(false)
        sun.setLightBrightness(0.3)
        sun.setMaterialColor(float4(1, 1, 1, 1))
        sun.setLightColor(float3(1, 1, 1))
        sun.setLightBrightness(0.3)
        addLight(sun)
    }
    
    func buildCruiserPhongScene() {
        cruiser.setMaterialAmbient(0.01)
        addChild(cruiser)
    }
    
    func buildQuadMipmapPhongScene() {
        quad.setMaterialAmbient(0.3)
        quad.setMaterialShininess(10)
        quad.setMaterialSpecular(5)
        quad.setTexture(.BreakingBad)
        quad.setPositionZ(-2)
        addChild(quad)
    }
    
    func addPhongLights() {
        leftSun.setPosition(float3(-1, 1, 0))
        leftSun.setMaterialIsLit(false)
        leftSun.setMaterialColor(float4(1, 0, 0, 1))
        leftSun.setLightColor(float3(1, 0, 0))
        leftSun.setLightBrightness(0.3)
        addLight(leftSun)

        rightSun.setPosition(float3(1, 1, 0))
        rightSun.setMaterialIsLit(false)
        rightSun.setMaterialColor(float4(0, 0, 1, 1))
        rightSun.setLightColor(float3(0, 0, 1))
        rightSun.setLightBrightness(0.3)
        addLight(rightSun)
    }
}

