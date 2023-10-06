import { loadScene_bvh_demo_highlight_large_objects } from "./loadScene.js";

export const fetchSceneAndMount_bvh_demo_highlight_large_objects =
  async function (options = {}) {
    if (options && options.createViewer == null) {
      options.createViewer = true;
    }
    return loadScene_bvh_demo_highlight_large_objects(options);
  };
