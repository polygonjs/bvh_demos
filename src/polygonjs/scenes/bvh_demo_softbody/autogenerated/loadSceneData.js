import { SceneDataManifestImporter } from "@polygonjs/polygonjs/dist/src/engine/io/manifest/import/SceneData";
const manifest = {
  properties: "1696602532873",
  root: "1696602532873",
  nodes: {
    COP: "1696602550547",
    env: "1696602550547",
    "env/MAT": "1696602550547",
    "env/MAT/meshStandardBuilder1": "1696628592248",
    cameras: "1696602550547",
    "cameras/cameraControls1": "1696628592248",
    lights: "1696602550547",
    geo1: "1696628592248",
    "geo1/tetSoftBodySolver1": "1696602550547",
    "geo1/actor_softBody1": "1696602550547",
    "geo1/MAT": "1696602550547",
  },
  shaders: {
    "/env/MAT/meshStandardBuilder1": {
      vertex: "1696602550547",
      fragment: "1696602550547",
      "customDepthMaterial.vertex": "1696602550547",
      "customDepthMaterial.fragment": "1696602550547",
      "customDistanceMaterial.vertex": "1696602550547",
      "customDistanceMaterial.fragment": "1696602550547",
      "customDepthDOFMaterial.vertex": "1696602550547",
      "customDepthDOFMaterial.fragment": "1696602550547",
    },
  },
  jsFunctionBodies: {
    "/geo1/tetSoftBodySolver1": "1696628592248",
    "/geo1/actor_softBody1": "1696602550547",
  },
};

export const loadSceneData_bvh_demo_softbody = async (options = {}) => {
  const sceneDataRoot = options.sceneDataRoot || "./polygonjs/scenes";
  return await SceneDataManifestImporter.importSceneData({
    sceneName: "bvh_demo_softbody",
    urlPrefix: sceneDataRoot + "/bvh_demo_softbody",
    manifest: manifest,
    onProgress: options.onProgress,
  });
};
