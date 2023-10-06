import { fetchSceneAndMount_bvh_demo_boolean } from "./fetchSceneAndMount.js";

export async function loadSceneAndMount_bvh_demo_boolean(options) {
  const { publicPath, onProgress } = options;
  const domElement = options.domElement || "polygonjs-app-bvh_demo_boolean";
  const loadedData = await fetchSceneAndMount_bvh_demo_boolean({
    domElement,
    autoPlay: true,
    onProgress,
    sceneDataRoot: publicPath + "/polygonjs/scenes",
    assetsRoot: publicPath,
    libsRootPrefix: publicPath,
  });
  return loadedData;
}
