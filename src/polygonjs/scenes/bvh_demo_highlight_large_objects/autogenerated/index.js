import { fetchSceneAndMount_bvh_demo_highlight_large_objects } from "./fetchSceneAndMount.js";

export async function loadSceneAndMount_bvh_demo_highlight_large_objects(
  options
) {
  const { publicPath, onProgress } = options;
  const domElement =
    options.domElement || "polygonjs-app-bvh_demo_highlight_large_objects";
  const loadedData = await fetchSceneAndMount_bvh_demo_highlight_large_objects({
    domElement,
    autoPlay: true,
    onProgress,
    sceneDataRoot: publicPath + "/polygonjs/scenes",
    assetsRoot: publicPath,
    libsRootPrefix: publicPath,
  });
  return loadedData;
}
