//
//  Entities.swift
//  GameEngine
//
//  Created by 徐浩博 on 2020/12/5.
//

class Entities {
    private static var _meshLibrary: MeshLibrary!
    public static var Meshes: MeshLibrary {
        return _meshLibrary
    }
    
    public static func Initialize() {
        self._meshLibrary = MeshLibrary()
    }
}
