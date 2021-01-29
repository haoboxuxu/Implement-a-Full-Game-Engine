//
//  ColorUtils.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/23.
//

import simd

class ColorUtil {
    public static var randomColor: float4 {
        return float4(Float.randomZeroToOne, Float.randomZeroToOne, Float.randomZeroToOne, 1.0)
    }
}
