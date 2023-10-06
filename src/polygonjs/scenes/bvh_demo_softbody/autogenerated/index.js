import { fetchSceneAndMount_bvh_demo_softbody } from "./fetchSceneAndMount.js";

export async function loadSceneAndMount_bvh_demo_softbody(options) {
  const { publicPath, onProgress } = options;
  const domElement = options.domElement || "polygonjs-app-bvh_demo_softbody";
  const loadedData = await fetchSceneAndMount_bvh_demo_softbody({
    domElement,
    autoPlay: true,
    onProgress,
    sceneDataRoot: publicPath + "/polygonjs/scenes",
    assetsRoot: publicPath,
    libsRootPrefix: publicPath,
  });
  return loadedData;
}
