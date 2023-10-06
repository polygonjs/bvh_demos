import { loadScene_bvh_demo_boolean } from "./loadScene.js";

export const fetchSceneAndMount_bvh_demo_boolean = async function (
  options = {}
) {
  if (options && options.createViewer == null) {
    options.createViewer = true;
  }
  return loadScene_bvh_demo_boolean(options);
};
