import { SceneDataManifestImporter } from "@polygonjs/polygonjs/dist/src/engine/io/manifest/import/SceneData";
const manifest = {
  properties: "1696602176795",
  root: "1696599627622",
  nodes: {
    geo1: "1696602119318",
    "geo1/MAT": "1696602119318",
    "geo1/MAT/pointsBuilder1": "1696602139250",
    "geo1/MAT/lineBasicBuilder_LIGHTING": "1696602139250",
    "geo1/actor_for_each_line": "1696602139250",
    "geo1/actor_for_lines_parent": "1696602119318",
    "geo1/actor1": "1696602119318",
    COP: "1696599627622",
    cameras: "1696602254337",
    "cameras/cameraControls1": "1696602254337",
    env: "1696602119318",
    "env/MAT": "1696602119318",
    "env/MAT/meshStandardBuilder1": "1696602139250",
    lights: "1696602119318",
  },
  shaders: {
    "/geo1/MAT/pointsBuilder1": {
      vertex: "1696602119318",
      fragment: "1696602119318",
      "customDistanceMaterial.vertex": "1696602119318",
      "customDistanceMaterial.fragment": "1696602119318",
      "customDepthMaterial.vertex": "1696602119318",
      "customDepthMaterial.fragment": "1696602119318",
      "customDepthDOFMaterial.vertex": "1696602119318",
      "customDepthDOFMaterial.fragment": "1696602119318",
    },
    "/geo1/MAT/lineBasicBuilder_LIGHTING": {
      vertex: "1696602119318",
      fragment: "1696602119318",
      "customDistanceMaterial.vertex": "1696602119318",
      "customDistanceMaterial.fragment": "1696602119318",
      "customDepthMaterial.vertex": "1696602119318",
      "customDepthMaterial.fragment": "1696602119318",
      "customDepthDOFMaterial.vertex": "1696602119318",
      "customDepthDOFMaterial.fragment": "1696602119318",
    },
    "/env/MAT/meshStandardBuilder1": {
      vertex: "1696602119318",
      fragment: "1696602119318",
      "customDepthMaterial.vertex": "1696602119318",
      "customDepthMaterial.fragment": "1696602119318",
      "customDistanceMaterial.vertex": "1696602119318",
      "customDistanceMaterial.fragment": "1696602119318",
      "customDepthDOFMaterial.vertex": "1696602119318",
      "customDepthDOFMaterial.fragment": "1696602119318",
    },
  },
  jsFunctionBodies: {
    "/geo1/actor_for_each_line": "1696602119318",
    "/geo1/actor_for_lines_parent": "1696602119318",
    "/geo1/actor1": "1696602119318",
  },
};

export const loadSceneData_bvh_demo_lightning = async (options = {}) => {
  const sceneDataRoot = options.sceneDataRoot || "./polygonjs/scenes";
  return await SceneDataManifestImporter.importSceneData({
    sceneName: "bvh_demo_lightning",
    urlPrefix: sceneDataRoot + "/bvh_demo_lightning",
    manifest: manifest,
    onProgress: options.onProgress,
  });
};
