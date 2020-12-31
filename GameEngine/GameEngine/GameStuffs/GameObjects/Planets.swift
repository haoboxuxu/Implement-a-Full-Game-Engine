//
//  Planets.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/29.
//

import Foundation

class EarthDaymap: LightObject {
    init() {
        super.init(name: "EarthDaymap", meshType: .Sphere)
        useBaseColorTexture(.earth_daymap)
        setPosition(float3(0, 20, -100))
        setScale(20)
    }
}


class EarthNightmap: LightObject {
    init() {
        super.init(name: "EarthDaymap", meshType: .Sphere)
        useBaseColorTexture(.earth_nightmap)
        setPosition(float3(0, 20, -100))
        setScale(20)
    }
}
