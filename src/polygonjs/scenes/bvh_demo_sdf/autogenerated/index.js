import { fetchSceneAndMount_bvh_demo_sdf } from "./fetchSceneAndMount.js";

export async function loadSceneAndMount_bvh_demo_sdf(options) {
  const { publicPath, onProgress } = options;
  const domElement = options.domElement || "polygonjs-app-bvh_demo_sdf";
  const loadedData = await fetchSceneAndMount_bvh_demo_sdf({
    domElement,
    autoPlay: true,
    onProgress,
    sceneDataRoot: publicPath + "/polygonjs/scenes",
    assetsRoot: publicPath,
    libsRootPrefix: publicPath,
  });
  return loadedData;
}
