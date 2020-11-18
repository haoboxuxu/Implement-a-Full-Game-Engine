//
//  MyShaders.metal
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/18.
//

#include <metal_stdlib>
using namespace metal;


vertex float4 basic_vertex_shader() {
    return float4(1);
}

fragment half4 basic_fragment_shader() {
    return half4(1);
}
