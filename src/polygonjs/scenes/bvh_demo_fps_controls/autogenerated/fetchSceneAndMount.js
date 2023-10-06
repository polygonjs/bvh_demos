import { loadScene_bvh_demo_fps_controls } from "./loadScene.js";

export const fetchSceneAndMount_bvh_demo_fps_controls = async function (
  options = {}
) {
  if (options && options.createViewer == null) {
    options.createViewer = true;
  }
  return loadScene_bvh_demo_fps_controls(options);
};
