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
    var middleSun = Sun()



    override func buildScene() {
        debugCamera.setPosition(float3(0, 0, 4))
        addCamera(debugCamera)


         // Phong Shadering
        leftSun.setPosition(float3(-1, 1, 0))
        leftSun.setMaterialIsLit(false)
        leftSun.setMaterialColor(float4(1, 0, 0, 1))
        leftSun.setLightColor(float3(1, 0, 0))
        leftSun.setLightBrightness(0.3)
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
        rightSun.setLightBrightness(0.3)
        addLight(rightSun)

        cruiser.setMaterialAmbient(0.01)
        //addChild(cruiser)

        quad.setMaterialAmbient(0.3)
        quad.setMaterialShininess(10)
        quad.setMaterialSpecular(5)
        quad.setTexture(.BreakingBad)
        quad.setPositionZ(-2)
        addChild(quad)
    }

    override func doUpdate() {

        if (Mouse.IsMouseButtonPressed(button: .left)) {
            let mouseDY = Mouse.GetDY() * GameTime.DeltaTime
            let mouseDX = Mouse.GetDX() * GameTime.DeltaTime
            cruiser.rotate(mouseDY, mouseDX, 0)
            quad.rotate(mouseDY, mouseDX, 0)
        }
        /* // Phong Shadering
        leftSun.setPositionX(cos(GameTime.TotalGameTime) - 1)
        middleSun.setPositionX(cos(GameTime.TotalGameTime))
        rightSun.setPositionX(cos(GameTime.TotalGameTime) + 1)
        cruiser.setMaterialShininess(max(cruiser.getMaterialShininess() + Mouse.GetDWheel(), 0))
        */
    }
}

