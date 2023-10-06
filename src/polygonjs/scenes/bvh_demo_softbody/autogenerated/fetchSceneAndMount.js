import { loadScene_bvh_demo_softbody } from "./loadScene.js";

export const fetchSceneAndMount_bvh_demo_softbody = async function (
  options = {}
) {
  if (options && options.createViewer == null) {
    options.createViewer = true;
  }
  return loadScene_bvh_demo_softbody(options);
};
