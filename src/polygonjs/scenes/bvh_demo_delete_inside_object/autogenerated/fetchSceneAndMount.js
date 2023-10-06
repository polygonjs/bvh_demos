import { loadScene_bvh_demo_delete_inside_object } from "./loadScene.js";

export const fetchSceneAndMount_bvh_demo_delete_inside_object = async function (
  options = {}
) {
  if (options && options.createViewer == null) {
    options.createViewer = true;
  }
  return loadScene_bvh_demo_delete_inside_object(options);
};
