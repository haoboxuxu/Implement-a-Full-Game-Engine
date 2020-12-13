//
//  shader.metal
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/5.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
    float2 textureCoordinate [[ attribute(2) ]];
    float3 normal[[ attribute(3) ]];
};

struct RasterizerData {
    float4 position [[ position ]];
    float4 color;
    float2 textureCoordinate;
    float totalGameTime;
    float3 worldPosition;
    float3 surfaceNormal;
};

struct ModelConstants {
    float4x4 modelMatrix;
};

struct SceneConstants {
    float totalGameTime;
    float4x4 viewMatrix;
    float4x4 projectionMatrix;
};

struct Material {
    float4 color;
    bool useMaterialColor;
    bool useTexture;
    bool isLit;
    float3 ambient;
    float3 difuse;
};

struct LightData {
    float3 position;
    float3 color;
    float brightness;
    float ambientIntensity;
    float difuseIntensity;
};
