//
//  UnRealScene.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/29.
//

import MetalKit

class UnRealScene: Scene {

    var debugCamera = DebugCamera()

    override func buildScene() {
        debugCamera.setPosition(float3(0, 1, 3))
        debugCamera.setRotationX(Float(-10).toRadians)
        addCamera(debugCamera)
        
        let sunColor = float4(0.7, 0.5, 0, 1.0)
        var sunMaterial = Material()
        sunMaterial.color = sunColor
        sunMaterial.isLit = false
        let sun = LightObject(name: "sun", meshType: .Sphere)
        sun.useMaterial(sunMaterial)
        sun.setScale(5)
        sun.setPosition(float3(0, 100, 100))
        addLight(sun)
        
        addChild(EarthNightmap())
        
        let light = LightObject(name: "light")
        light.setPosition(float3(0, 100, -100))
        light.setLightBrightness(0.5)
        addLight(light)
        
        //terrian
        let terrain = Terrain()
        addChild(terrain)
        
        //trees
        let trees = TreesInstance(treeDecoratedCount: 500, treePineSnowCount: 500, treePineSnowedCount: 500)
        addChild(trees)
        
        //presents
        let presents = PresentInstance(presentCount: 200, presentGreenCount: 200)
        addChild(presents)
        
        //snowmen
        let snowman = SnowmenInstance(snowmanCount: 50, snowmanFancyCount: 50)
        addChild(snowman)
        
        addStars()
        //let stars = StarInstance(starCount: 2000)
        //addChild(stars)
        
        let glaxySphere = GalaxySphere(skySphereTextureType: .galaxies)
        addChild(glaxySphere)
    }
    
    
    
    
    
    private func addStars() {
        for _ in 0...2000 {
            let star = GameObject(name: "star", meshType: .Sphere)
            star.setScale(0.1)
            let pos = float3(Float.random(in: -100...100),
                             Float.random(in: 0...200),
                             Float.random(in: -100...100))
            star.setPosition(pos)
            addChild(star)
        }
    }
}


