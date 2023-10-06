import { fetchSceneAndMount_bvh_demo_multiple_rays } from "./fetchSceneAndMount.js";

export async function loadSceneAndMount_bvh_demo_multiple_rays(options) {
  const { publicPath, onProgress } = options;
  const domElement =
    options.domElement || "polygonjs-app-bvh_demo_multiple_rays";
  const loadedData = await fetchSceneAndMount_bvh_demo_multiple_rays({
    domElement,
    autoPlay: true,
    onProgress,
    sceneDataRoot: publicPath + "/polygonjs/scenes",
    assetsRoot: publicPath,
    libsRootPrefix: publicPath,
  });
  return loadedData;
}
