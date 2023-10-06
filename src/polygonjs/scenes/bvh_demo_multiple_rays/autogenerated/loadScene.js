import { loadSceneData_bvh_demo_multiple_rays } from "./loadSceneData.js";

export const loadScene_bvh_demo_multiple_rays = async function (options = {}) {
  const {
    onProgress,
    domElement,
    configureSceneData,
    autoPlay,
    createViewer,
    sceneDataRoot,
    assetsRoot,
    libsRootPrefix,
    printWarnings,
    renderer,
    cameraMaskOverride,
  } = options;
  let sceneData = options.sceneData;

  const runRegister = options.runRegister != null ? options.runRegister : true;
  const loadModules = options.loadModules != null ? options.loadModules : true;

  const moduleNames = loadModules ? ["POLY_GL"] : [];
  const modulePromises = [import("./modules/POLY_GL.js")];
  const promises = [
    import("./loadSceneFromSceneData.js"),
    sceneData == null
      ? loadSceneData_bvh_demo_multiple_rays({ onProgress, sceneDataRoot })
      : (() => {
          return new Promise((resolve) => resolve());
        })(),
    ...modulePromises,
  ];
  const results = await Promise.all(promises);
  const { Poly, loadSceneFromSceneData_bvh_demo_multiple_rays } = results[0];
  if (sceneData == null) {
    sceneData = results[1];
  }
  if (configureSceneData) {
    configureSceneData(sceneData);
  }

  const loadedModules = [];
  for (let i = 2; i < results.length; i++) {
    loadedModules.push(results[i]);
  }
  // register modules
  let i = 0;
  for (let moduleName of moduleNames) {
    const moduleNameContainer = moduleName + "Module";
    Poly.registerModule(loadedModules[i][moduleNameContainer], printWarnings);
    i++;
  }

  const loadedData = await loadSceneFromSceneData_bvh_demo_multiple_rays({
    onProgress,
    sceneData,
    domElement,
    runRegister,
    autoPlay,
    createViewer,
    assetsRoot,
    libsRootPrefix,
    printWarnings,
    renderer,
    cameraMaskOverride,
  });
  return loadedData;
};
