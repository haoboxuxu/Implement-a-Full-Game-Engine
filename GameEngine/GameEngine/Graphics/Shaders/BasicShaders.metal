//
//  MyShaders.metal
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/18.
//

#include <metal_stdlib>
#include "ShaderData.metal"
using namespace metal;

vertex RasterizerData basic_vertex_shader(const VertexIn vIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                          constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    RasterizerData rd;
    rd.position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * modelConstants.modelMatrix * float4(vIn.position, 1);
    rd.color = vIn.color;
    rd.textureCoordinate = vIn.textureCoordinate;
    rd.totalGameTime = sceneConstants.totalGameTime;
    return rd;
}

fragment half4 basic_fragment_shader(RasterizerData rd [[ stage_in ]],
                                     constant Material &material [[ buffer(1) ]],
                                     constant LightData *lightData [[ buffer(2) ]],
                                     sampler sampler2d [[ sampler(0) ]],
                                     texture2d<float> texture[[ texture(0) ]]) {
    float2 texCoord = rd.textureCoordinate;
    float4 color;
    
    if (material.useTexture) {
        color = texture.sample(sampler2d, texCoord);
    }else if (material.useMaterialColor) {
        color = material.color;
    }else {
        color = rd.color;
    }
    
//    LightData light
    
    return half4(color.r, color.g, color.b, color.a);
}
