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
        
        addSun()
        
        
        // custom material
        //var material = Material()
        //material.diffuse = float3(0.2, 1, 0.2)
        //chest.useMaterial(material)
        
        addChild(chest)
    }

    override func doUpdate() {
        if (Mouse.IsMouseButtonPressed(button: .left)) {
            chest.rotate(Mouse.GetDY() * GameTime.DeltaTime, Mouse.GetDX() * GameTime.DeltaTime, 0)
        }
    }
    
    func addSun() {
        sun.setPosition(float3(0, 1, 10))
        sun.setLightBrightness(0.3)
        sun.setLightColor(float3(1, 1, 1))
        sun.setLightBrightness(0.3)
        sun.setLightAmbientIntensity(0.03)
        addLight(sun)
    }
    
    func buildCruiserPhongScene() {
        addChild(cruiser)
    }
    
    func buildQuadMipmapPhongScene() {
        quad.useBaseColorTexture(.BreakingBad)
        quad.setPositionZ(-2)
        addChild(quad)
    }
    
    func addPhongLights() {
        leftSun.setPosition(float3(-1, 1, 0))
        leftSun.setLightColor(float3(1, 0, 0))
        leftSun.setLightBrightness(0.3)
        addLight(leftSun)

        rightSun.setPosition(float3(1, 1, 0))
        rightSun.setLightColor(float3(0, 0, 1))
        rightSun.setLightBrightness(0.3)
        addLight(rightSun)
    }
}

