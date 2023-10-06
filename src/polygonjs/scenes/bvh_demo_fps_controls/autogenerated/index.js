import { fetchSceneAndMount_bvh_demo_fps_controls } from "./fetchSceneAndMount.js";

export async function loadSceneAndMount_bvh_demo_fps_controls(options) {
  const { publicPath, onProgress } = options;
  const domElement =
    options.domElement || "polygonjs-app-bvh_demo_fps_controls";
  const loadedData = await fetchSceneAndMount_bvh_demo_fps_controls({
    domElement,
    autoPlay: true,
    onProgress,
    sceneDataRoot: publicPath + "/polygonjs/scenes",
    assetsRoot: publicPath,
    libsRootPrefix: publicPath,
  });
  return loadedData;
}
