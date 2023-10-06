import { loadScene_scene_01 } from "./loadScene.js";

export const fetchSceneAndMount_scene_01 = async function (options = {}) {
  if (options && options.createViewer == null) {
    options.createViewer = true;
  }
  return loadScene_scene_01(options);
};
