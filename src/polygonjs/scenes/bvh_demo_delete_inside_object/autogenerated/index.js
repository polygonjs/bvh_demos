import { fetchSceneAndMount_bvh_demo_delete_inside_object } from "./fetchSceneAndMount.js";

export async function loadSceneAndMount_bvh_demo_delete_inside_object(options) {
  const { publicPath, onProgress } = options;
  const domElement =
    options.domElement || "polygonjs-app-bvh_demo_delete_inside_object";
  const loadedData = await fetchSceneAndMount_bvh_demo_delete_inside_object({
    domElement,
    autoPlay: true,
    onProgress,
    sceneDataRoot: publicPath + "/polygonjs/scenes",
    assetsRoot: publicPath,
    libsRootPrefix: publicPath,
  });
  return loadedData;
}
