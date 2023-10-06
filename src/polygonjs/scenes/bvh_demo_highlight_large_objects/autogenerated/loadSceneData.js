import { SceneDataManifestImporter } from "@polygonjs/polygonjs/dist/src/engine/io/manifest/import/SceneData";
const manifest = {
  properties: "1696603591811",
  root: "1696603591811",
  nodes: {
    COP: "1696603591811",
    env: "1696603622434",
    "env/MAT": "1696603622434",
    "env/MAT/meshStandardBuilder1": "1696603622434",
    cameras: "1696603622434",
    "cameras/cameraControls1": "1696603622434",
    lights: "1696603622434",
    geo1: "1696603622434",
    "geo1/MAT": "1696603622434",
    "geo1/MAT/meshStandardBuilder1": "1696603622434",
    "geo1/actor1": "1696603622434",
  },
  shaders: {
    "/env/MAT/meshStandardBuilder1": {
      vertex: "1696603622434",
      fragment: "1696603622434",
      "customDepthMaterial.vertex": "1696603622434",
      "customDepthMaterial.fragment": "1696603622434",
      "customDistanceMaterial.vertex": "1696603622434",
      "customDistanceMaterial.fragment": "1696603622434",
      "customDepthDOFMaterial.vertex": "1696603622434",
      "customDepthDOFMaterial.fragment": "1696603622434",
    },
    "/geo1/MAT/meshStandardBuilder1": {
      vertex: "1696603622434",
      fragment: "1696603622434",
      "customDepthMaterial.vertex": "1696603622434",
      "customDepthMaterial.fragment": "1696603622434",
      "customDistanceMaterial.vertex": "1696603622434",
      "customDistanceMaterial.fragment": "1696603622434",
      "customDepthDOFMaterial.vertex": "1696603622434",
      "customDepthDOFMaterial.fragment": "1696603622434",
    },
  },
  jsFunctionBodies: { "/geo1/actor1": "1696603622434" },
};

export const loadSceneData_bvh_demo_highlight_large_objects = async (
  options = {}
) => {
  const sceneDataRoot = options.sceneDataRoot || "./polygonjs/scenes";
  return await SceneDataManifestImporter.importSceneData({
    sceneName: "bvh_demo_highlight_large_objects",
    urlPrefix: sceneDataRoot + "/bvh_demo_highlight_large_objects",
    manifest: manifest,
    onProgress: options.onProgress,
  });
};
