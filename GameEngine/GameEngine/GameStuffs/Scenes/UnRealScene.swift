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
        let presentCount: Int = 50
        for i in 0..<presentCount {
            let radius: Float = Float.random(in: 5...30)
            let present = GameObject(name: "present", meshType: selectRandomPresenMeshType())
            let pos = float3(cos(Float(i)) * radius,
                             0,
                             sin(Float(i)) * radius)
            present.setPosition(pos)
            present.rotateY(Float.random(in: 0...360))
            addChild(present)
        }
        
        //snowmen
        let snowmanCount: Int = 50
        for i in 0..<snowmanCount {
            let radius: Float = Float.random(in: 5...30)
            let snowman = GameObject(name: "snowmanFancy", meshType: selectRandomSnowmanMeshType())
            let pos = float3(cos(Float(i)) * radius,
                             0,
                             sin(Float(i)) * radius)
            snowman.setPosition(pos)
            snowman.rotateY(Float.random(in: 0...360))
            addChild(snowman)
        }
        
        addStars()
    }
    
    private func selectRandomPresenMeshType() -> MeshTypes {
        let randVal = Int.random(in: 0...1)
        switch randVal {
        case 0:
            return .present
        case 1:
            return .presentGreen
        default:
            return .present
        }
    }
    
    private func selectRandomSnowmanMeshType() -> MeshTypes {
        let randVal = Int.random(in: 0...1)
        switch randVal {
        case 0:
            return .snowman
        case 1:
            return .snowmanFancy
        default:
            return .snowmanFancy
        }
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


