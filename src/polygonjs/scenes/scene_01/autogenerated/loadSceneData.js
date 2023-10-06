import { SceneDataManifestImporter } from "@polygonjs/polygonjs/dist/src/engine/io/manifest/import/SceneData";
const manifest = {
  properties: "1696598600789",
  root: "1696598516906",
  nodes: {
    COP: "1696598516906",
    "COP/builder1": "1696598516906",
    cameras: "1696598516906",
    "cameras/cameraControls1": "1696598516906",
    "cameras/cameraRenderer1": "1696598516906",
    lights: "1696598516906",
    geo1: "1696598600789",
    "geo1/MAT": "1696598516906",
    "geo1/subnet1": "1696598600789",
    "geo1/subnet1/pointBuilder1": "1696598516906",
  },
  shaders: { "/COP/builder1": { fragment: "1696598600789" } },
  jsFunctionBodies: { "/geo1/subnet1/pointBuilder1": "1696598600789" },
};

export const loadSceneData_scene_01 = async (options = {}) => {
  const sceneDataRoot = options.sceneDataRoot || "./polygonjs/scenes";
  return await SceneDataManifestImporter.importSceneData({
    sceneName: "scene_01",
    urlPrefix: sceneDataRoot + "/scene_01",
    manifest: manifest,
    onProgress: options.onProgress,
  });
};
