//
//  LightObject.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/12.
//

import MetalKit

class LightObject: GameObject {
    var lightData = LightData()
    
    init(name: String) {
        super.init(meshType: .None)
        self.setName(name)
    }
    
    init(meshType: MeshTypes, name: String) {
        super.init(meshType: meshType)
        print("LightObject meshType \(meshType)")
        self.setName(name)
    }
    
    override func update() {
        self.lightData.position = self.getPosition()
        super.update()
    }
}


extension LightObject {
    public func setLightColor(_ color: float3) { self.lightData.color = color }
    public func getLightColor() -> float3 { return self.lightData.color }
    
    public func setLightBrightness(_ brightness: Float) { self.lightData.brightness = brightness }
    public func getLightBrightness() -> Float { return self.lightData.brightness }
    
    public func setAmbientIntensity(_ intensity: Float) { self.lightData.ambientIntensity = intensity }
    public func getAmbientIntensity() -> Float { return self.lightData.ambientIntensity }
}
