import { SceneDataManifestImporter } from "@polygonjs/polygonjs/dist/src/engine/io/manifest/import/SceneData";
const manifest = {
  properties: "1696603480758",
  root: "1696603480758",
  nodes: {
    COP: "1696603480758",
    env: "1696603490485",
    "env/MAT": "1696603490485",
    "env/MAT/meshStandardBuilder1": "1696603490485",
    cameras: "1696603490485",
    "cameras/cameraControls1": "1696603509984",
    lights: "1696603490485",
    geo1: "1696603509984",
  },
  shaders: {
    "/env/MAT/meshStandardBuilder1": {
      vertex: "1696603490485",
      fragment: "1696603490485",
      "customDepthMaterial.vertex": "1696603490485",
      "customDepthMaterial.fragment": "1696603490485",
      "customDistanceMaterial.vertex": "1696603490485",
      "customDistanceMaterial.fragment": "1696603490485",
      "customDepthDOFMaterial.vertex": "1696603490485",
      "customDepthDOFMaterial.fragment": "1696603490485",
    },
  },
  jsFunctionBodies: {},
};

export const loadSceneData_bvh_demo_boolean = async (options = {}) => {
  const sceneDataRoot = options.sceneDataRoot || "./polygonjs/scenes";
  return await SceneDataManifestImporter.importSceneData({
    sceneName: "bvh_demo_boolean",
    urlPrefix: sceneDataRoot + "/bvh_demo_boolean",
    manifest: manifest,
    onProgress: options.onProgress,
  });
};
