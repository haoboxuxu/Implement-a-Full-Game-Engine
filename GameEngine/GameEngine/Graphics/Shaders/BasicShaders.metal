//
//  MyShaders.metal
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/18.
//

#include <metal_stdlib>
#include "Lighting.metal"
#include "ShaderData.metal"
using namespace metal;

vertex RasterizerData basic_vertex_shader(const VertexIn vIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                          constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    RasterizerData rd;
    float4 worldPosition = modelConstants.modelMatrix * float4(vIn.position, 1);
    
    rd.position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * modelConstants.modelMatrix * float4(vIn.position, 1);
    rd.color = vIn.color;
    rd.textureCoordinate = vIn.textureCoordinate;
    rd.totalGameTime = sceneConstants.totalGameTime;
    rd.worldPosition = worldPosition.xyz;
    rd.surfaceNormal = (modelConstants.modelMatrix * float4(vIn.normal, 0.0)).xyz;
    rd.toCameraVector = sceneConstants.cameraPosition - worldPosition.xyz;
    
    return rd;
}

fragment half4 basic_fragment_shader(RasterizerData rd [[ stage_in ]],
                                     constant Material &material [[ buffer(1) ]],
                                     constant int &lightCount [[ buffer(2) ]],
                                     constant LightData *lightDatas [[ buffer(3) ]],
                                     sampler sampler2d [[ sampler(0) ]],
                                     texture2d<float> baseColorMap[[ texture(0) ]]) {
    
    float2 texCoord = rd.textureCoordinate;
    float4 color = material.color;
    
    if (!is_null_texture(baseColorMap)) {
        color = baseColorMap.sample(sampler2d, texCoord);
    }
    
    if (material.isLit) {
        
        float3 unitNormal = normalize(rd.surfaceNormal);
        float3 unitToCameraVector = normalize(rd.toCameraVector);
        
        float3 phongintensity = Lighting::GetPhongIntensity(material, lightDatas, lightCount, rd.worldPosition, unitNormal, unitToCameraVector);
        color *= float4(phongintensity, 1.0);
    }
    
    return half4(color.r, color.g, color.b, color.a);
}
