import { fetchSceneAndMount_bvh_demo_pathtracing } from "./fetchSceneAndMount.js";

export async function loadSceneAndMount_bvh_demo_pathtracing(options) {
  const { publicPath, onProgress } = options;
  const domElement = options.domElement || "polygonjs-app-bvh_demo_pathtracing";
  const loadedData = await fetchSceneAndMount_bvh_demo_pathtracing({
    domElement,
    autoPlay: true,
    onProgress,
    sceneDataRoot: publicPath + "/polygonjs/scenes",
    assetsRoot: publicPath,
    libsRootPrefix: publicPath,
  });
  return loadedData;
}
