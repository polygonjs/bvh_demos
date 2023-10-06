import { loadScene_bvh_demo_pathtracing } from "./loadScene.js";

export const fetchSceneAndMount_bvh_demo_pathtracing = async function (
  options = {}
) {
  if (options && options.createViewer == null) {
    options.createViewer = true;
  }
  return loadScene_bvh_demo_pathtracing(options);
};
