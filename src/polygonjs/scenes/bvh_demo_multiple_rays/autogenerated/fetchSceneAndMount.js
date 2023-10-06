import { loadScene_bvh_demo_multiple_rays } from "./loadScene.js";

export const fetchSceneAndMount_bvh_demo_multiple_rays = async function (
  options = {}
) {
  if (options && options.createViewer == null) {
    options.createViewer = true;
  }
  return loadScene_bvh_demo_multiple_rays(options);
};
