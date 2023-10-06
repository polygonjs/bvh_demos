import { loadSceneData_bvh_demo_delete_inside_object } from "./loadSceneData.js";

export const loadScene_bvh_demo_delete_inside_object = async function (
  options = {}
) {
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

  const moduleNames = loadModules ? [] : [];
  const promises = [
    import("./loadSceneFromSceneData.js"),
    sceneData == null
      ? loadSceneData_bvh_demo_delete_inside_object({
          onProgress,
          sceneDataRoot,
        })
      : (() => {
          return new Promise((resolve) => resolve());
        })(),
  ];
  const results = await Promise.all(promises);
  const { Poly, loadSceneFromSceneData_bvh_demo_delete_inside_object } =
    results[0];
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

  const loadedData = await loadSceneFromSceneData_bvh_demo_delete_inside_object(
    {
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
    }
  );
  return loadedData;
};
