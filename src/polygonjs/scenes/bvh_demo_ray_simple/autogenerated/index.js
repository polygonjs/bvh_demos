import { fetchSceneAndMount_bvh_demo_ray_simple } from "./fetchSceneAndMount.js";

export async function loadSceneAndMount_bvh_demo_ray_simple(options) {
  const { publicPath, onProgress } = options;
  const domElement = options.domElement || "polygonjs-app-bvh_demo_ray_simple";
  const loadedData = await fetchSceneAndMount_bvh_demo_ray_simple({
    domElement,
    autoPlay: true,
    onProgress,
    sceneDataRoot: publicPath + "/polygonjs/scenes",
    assetsRoot: publicPath,
    libsRootPrefix: publicPath,
  });
  return loadedData;
}
