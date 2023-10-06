import { SceneDataManifestImporter } from "@polygonjs/polygonjs/dist/src/engine/io/manifest/import/SceneData";
const manifest = {
  properties: "1696598649335",
  root: "1696598516906",
  nodes: {
    COP: "1696598516906",
    "COP/builder1": "1696598516906",
    cameras: "1696598516906",
    "cameras/cameraControls1": "1696598516906",
    "cameras/cameraRenderer1": "1696611428735",
    lights: "1696598516906",
    geo1: "1696598600789",
    "geo1/MAT": "1696598516906",
    "geo1/subnet1": "1696598600789",
    "geo1/subnet1/pointBuilder1": "1696611161448",
  },
  shaders: { "/COP/builder1": { fragment: "1696598600789" } },
  jsFunctionBodies: { "/geo1/subnet1/pointBuilder1": "1696611161448" },
};

export const loadSceneData_bvh_demo_pathtracing = async (options = {}) => {
  const sceneDataRoot = options.sceneDataRoot || "./polygonjs/scenes";
  return await SceneDataManifestImporter.importSceneData({
    sceneName: "bvh_demo_pathtracing",
    urlPrefix: sceneDataRoot + "/bvh_demo_pathtracing",
    manifest: manifest,
    onProgress: options.onProgress,
  });
};
