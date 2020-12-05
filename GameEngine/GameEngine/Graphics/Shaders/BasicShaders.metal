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
                                     constant Material &material [[ buffer(1) ]]) {
    //float4 color = material.useMaterialColor ? material.color : rd.color;
    float2 texCoord = rd.textureCoordinate;
    float gameTime = rd.totalGameTime;
    
    float x = sin((texCoord.x + gameTime) * 20);
    float y = sin((texCoord.y - gameTime) * 20);
    float z = tan((texCoord.x + gameTime) * 20);
    float4 color = float4(x, y, z, 1);
    return half4(color.r, color.g, color.b, color.a);
}
