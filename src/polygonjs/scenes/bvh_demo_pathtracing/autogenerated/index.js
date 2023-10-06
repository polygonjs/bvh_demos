import { fetchSceneAndMount_scene_01 } from "./fetchSceneAndMount.js";

export async function loadSceneAndMount_scene_01(options) {
  const { publicPath, onProgress } = options;
  const domElement = options.domElement || "polygonjs-app-scene_01";
  const loadedData = await fetchSceneAndMount_scene_01({
    domElement,
    autoPlay: true,
    onProgress,
    sceneDataRoot: publicPath + "/polygonjs/scenes",
    assetsRoot: publicPath,
    libsRootPrefix: publicPath,
  });
  return loadedData;
}
