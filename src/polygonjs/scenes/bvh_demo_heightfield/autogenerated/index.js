import { fetchSceneAndMount_bvh_demo_heightfield } from "./fetchSceneAndMount.js";

export async function loadSceneAndMount_bvh_demo_heightfield(options) {
  const { publicPath, onProgress } = options;
  const domElement = options.domElement || "polygonjs-app-bvh_demo_heightfield";
  const loadedData = await fetchSceneAndMount_bvh_demo_heightfield({
    domElement,
    autoPlay: true,
    onProgress,
    sceneDataRoot: publicPath + "/polygonjs/scenes",
    assetsRoot: publicPath,
    libsRootPrefix: publicPath,
  });
  return loadedData;
}
