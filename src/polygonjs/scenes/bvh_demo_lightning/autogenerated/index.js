import { fetchSceneAndMount_bvh_demo_lightning } from "./fetchSceneAndMount.js";

export async function loadSceneAndMount_bvh_demo_lightning(options) {
  const { publicPath, onProgress } = options;
  const domElement = options.domElement || "polygonjs-app-bvh_demo_lightning";
  const loadedData = await fetchSceneAndMount_bvh_demo_lightning({
    domElement,
    autoPlay: true,
    onProgress,
    sceneDataRoot: publicPath + "/polygonjs/scenes",
    assetsRoot: publicPath,
    libsRootPrefix: publicPath,
  });
  return loadedData;
}
