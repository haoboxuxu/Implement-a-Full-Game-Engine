//
//  Scene.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/11/20.
//

import MetalKit

class Scene: Node {
    
    var cameraManger = CameraManger()
    var sceneConstants = SceneConstants()
    
    init() {
        super.init(name: "Scene")
        buildScene()
    }
    
    func buildScene() { }
    
    func addCamera(_ camera: Camera, _ isCurrentCamera: Bool  = true) {
        cameraManger.registerCamera(camera: camera)
        if (isCurrentCamera) {
            cameraManger.setCamera(camera.cameraType)
        }
    }
    
    func updateSceneConstants() {
        sceneConstants.viewMatrix = cameraManger.currentCamera.viewMatrix
        sceneConstants.projectionMatrix = cameraManger.currentCamera.projectionMatrix
    }
    
    func updateCameras() {
        cameraManger.update()
    }
    
    override func update() {
        updateSceneConstants()
        super.update()
    }
    
    override func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBytes(&sceneConstants, length: SceneConstants.stride, index: 1)
        super.render(renderCommandEncoder: renderCommandEncoder)
    }
}
