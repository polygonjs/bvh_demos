import { loadScene_bvh_demo_ray_simple } from "./loadScene.js";

export const fetchSceneAndMount_bvh_demo_ray_simple = async function (
  options = {}
) {
  if (options && options.createViewer == null) {
    options.createViewer = true;
  }
  return loadScene_bvh_demo_ray_simple(options);
};
