//
//  InstanceShaders.metal
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/5.
//

#include <metal_stdlib>
#include "ShaderData.metal"
using namespace metal;

vertex RasterizerData instance_vertex_shader(const VertexIn vIn [[ stage_in ]],
                                             constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                             constant ModelConstants *modelConstants [[ buffer(2) ]],
                                             uint instanceId [[ instance_id ]]){
    RasterizerData rd;
    ModelConstants modelConstant = modelConstants[instanceId];
    rd.position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * modelConstant.modelMatrix * float4(vIn.position, 1);
    rd.color = vIn.color;
    
    return rd;
}
