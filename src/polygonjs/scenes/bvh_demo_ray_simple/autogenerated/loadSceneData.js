import { SceneDataManifestImporter } from "@polygonjs/polygonjs/dist/src/engine/io/manifest/import/SceneData";
const manifest = {
  properties: "1696599601787",
  root: "1696599561154",
  nodes: {
    geo1: "1696599612897",
    "geo1/MAT": "1696599568397",
    COP: "1696599612897",
    lights: "1696599568397",
    cameras: "1696599568397",
    "cameras/cameraControls1": "1696599568397",
    env: "1696599568397",
    "env/MAT": "1696599568397",
    "env/MAT/meshStandardBuilder1": "1696599568397",
  },
  shaders: {
    "/env/MAT/meshStandardBuilder1": {
      vertex: "1696599568397",
      fragment: "1696599568397",
      "customDepthMaterial.vertex": "1696599568397",
      "customDepthMaterial.fragment": "1696599568397",
      "customDistanceMaterial.vertex": "1696599568397",
      "customDistanceMaterial.fragment": "1696599568397",
      "customDepthDOFMaterial.vertex": "1696599568397",
      "customDepthDOFMaterial.fragment": "1696599568397",
    },
  },
  jsFunctionBodies: {},
};

export const loadSceneData_bvh_demo_ray_simple = async (options = {}) => {
  const sceneDataRoot = options.sceneDataRoot || "./polygonjs/scenes";
  return await SceneDataManifestImporter.importSceneData({
    sceneName: "bvh_demo_ray_simple",
    urlPrefix: sceneDataRoot + "/bvh_demo_ray_simple",
    manifest: manifest,
    onProgress: options.onProgress,
  });
};
