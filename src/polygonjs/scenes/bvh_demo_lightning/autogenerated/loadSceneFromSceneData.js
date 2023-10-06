import { ScenePlayerImporter } from "@polygonjs/polygonjs/dist/src/engine/io/player/Scene";
import { PolyNodeController } from "@polygonjs/polygonjs/dist/src/engine/nodes/utils/poly/PolyNodeController";
import { configureScene, configurePolygonjs } from "../PolyConfig";
import { Poly } from "@polygonjs/polygonjs/dist/src/engine/Poly";
import { AllExpressionsRegister } from "@polygonjs/polygonjs/dist/src/engine/poly/registers/expressions/All";
import { requiredImports_bvh_demo_lightning } from "./requiredImports";

const loadSceneFromSceneData_bvh_demo_lightning = async function (options) {
  const {
    domElement,
    sceneData,
    onProgress,
    autoPlay,
    createViewer,
    assetsRoot,
    libsRootPrefix,
    printWarnings,
    renderer,
    cameraMaskOverride,
  } = options;
  const runRegister = options.runRegister != null ? options.runRegister : true;

  if (runRegister) {
    // registers nodes required for this scene
    for (const node of requiredImports_bvh_demo_lightning.nodes) {
      Poly.registerNode(node, undefined, { printWarnings });
    }
    for (const operation of requiredImports_bvh_demo_lightning.operations) {
      Poly.registerOperation(operation, { printWarnings });
    }
    for (const jsFunction of requiredImports_bvh_demo_lightning.jsFunctions) {
      Poly.registerNamedFunction(jsFunction, { printWarnings });
    }
    const polyNodesData = [
      {
        node_context: "gl",
        node_type: "laserColor",
        data: {
          metadata: {
            version: { editor: "1.5.3-1", polygonjs: "1.5.3" },
            createdAt: 1696601847588,
          },
          nodeContext: "gl",
          inputs: { typed: { types: [{ name: "baseColor", type: "vec3" }] } },
          params: [],
          nodes: {
            constant1: {
              type: "constant",
              params: {
                type: 4,
                color: [
                  0.7011018919268015, 0.018500220124016656,
                  0.005181516700061659,
                ],
                asColor: true,
              },
              connection_points: {
                in: [],
                out: [{ name: "val", type: "vec3" }],
              },
            },
            attribute1: {
              type: "attribute",
              params: { name: "id" },
              connection_points: {
                in: [],
                out: [{ name: "val", type: "float" }],
              },
            },
            round1: {
              type: "round",
              params: {
                in: {
                  type: "float",
                  default_value: 0,
                  options: {
                    spare: true,
                    editable: false,
                    computeOnDirty: true,
                    dependentOnFoundParam: false,
                  },
                  overriden_options: {},
                },
              },
              inputs: [
                {
                  index: 0,
                  inputName: "in",
                  node: "attribute1",
                  output: "val",
                },
              ],
              connection_points: {
                in: [{ name: "in", type: "float" }],
                out: [{ name: "val", type: "float" }],
              },
            },
            random1: {
              type: "random",
              params: { seed: { overriden_options: {} } },
              inputs: [
                {
                  index: 0,
                  inputName: "seed",
                  node: "floatToVec2_1",
                  output: "vec2",
                },
              ],
            },
            floatToVec2_1: {
              type: "floatToVec2",
              params: {
                x: { overriden_options: {} },
                y: { raw_input: 0.54, overriden_options: {} },
              },
              inputs: [
                { index: 0, inputName: "x", node: "round1", output: "val" },
              ],
            },
            multAdd5: {
              type: "multAdd",
              params: {
                value: {
                  type: "float",
                  default_value: 0,
                  options: {
                    spare: true,
                    editable: false,
                    computeOnDirty: true,
                    dependentOnFoundParam: false,
                  },
                },
                preAdd: {
                  type: "float",
                  default_value: 0,
                  options: {
                    spare: true,
                    editable: true,
                    computeOnDirty: true,
                    dependentOnFoundParam: false,
                  },
                },
                mult: {
                  type: "float",
                  default_value: 1,
                  options: {
                    spare: true,
                    editable: true,
                    computeOnDirty: true,
                    dependentOnFoundParam: false,
                  },
                  raw_input: 4.4,
                },
                postAdd: {
                  type: "float",
                  default_value: 0,
                  options: {
                    spare: true,
                    editable: true,
                    computeOnDirty: true,
                    dependentOnFoundParam: false,
                  },
                },
              },
              inputs: [
                {
                  index: 0,
                  inputName: "value",
                  node: "random1",
                  output: "rand",
                },
              ],
              connection_points: {
                in: [
                  { name: "value", type: "float" },
                  { name: "preAdd", type: "float" },
                  { name: "mult", type: "float" },
                  { name: "postAdd", type: "float" },
                ],
                out: [{ name: "val", type: "float" }],
              },
            },
            constant2: {
              type: "constant",
              params: {
                type: 4,
                color: [
                  0.6653872982754769, 0.5583403896257968, 0.005181516700061659,
                ],
                asColor: true,
              },
              connection_points: {
                in: [],
                out: [{ name: "val", type: "vec3" }],
              },
            },
            rgbToOklab1: {
              type: "rgbToOklab",
              params: { rgb: { overriden_options: {} } },
              inputs: [
                {
                  index: 0,
                  inputName: "rgb",
                  node: "constant2",
                  output: "val",
                },
              ],
            },
            rgbToOklab2: {
              type: "rgbToOklab",
              params: { rgb: { overriden_options: {} } },
              inputs: [
                {
                  index: 0,
                  inputName: "rgb",
                  node: "constant1",
                  output: "val",
                },
              ],
            },
            oklabToRgb1: {
              type: "oklabToRgb",
              params: { oklab: { overriden_options: {} } },
              inputs: [
                { index: 0, inputName: "oklab", node: "mix1", output: "mix" },
              ],
            },
            mix1: {
              type: "mix",
              params: {
                value0: {
                  type: "vector3",
                  default_value: [0, 0, 0],
                  options: {
                    spare: true,
                    editable: false,
                    computeOnDirty: true,
                    dependentOnFoundParam: false,
                  },
                  overriden_options: {},
                },
                value1: {
                  type: "vector3",
                  default_value: [0, 0, 0],
                  options: {
                    spare: true,
                    editable: false,
                    computeOnDirty: true,
                    dependentOnFoundParam: false,
                  },
                },
                blend: {
                  type: "float",
                  default_value: 0.5,
                  options: {
                    spare: true,
                    editable: false,
                    computeOnDirty: true,
                    dependentOnFoundParam: false,
                  },
                },
              },
              inputs: [
                {
                  index: 0,
                  inputName: "value0",
                  node: "rgbToOklab1",
                  output: "oklab",
                },
                {
                  index: 1,
                  inputName: "value1",
                  node: "rgbToOklab2",
                  output: "oklab",
                },
                { index: 2, inputName: "blend", node: "pow1", output: "val" },
              ],
              connection_points: {
                in: [
                  { name: "value0", type: "vec3" },
                  { name: "value1", type: "vec3" },
                  { name: "blend", type: "float" },
                ],
                out: [{ name: "mix", type: "vec3" }],
              },
            },
            pow1: {
              type: "pow",
              params: {
                x: {
                  type: "float",
                  default_value: 0,
                  options: {
                    spare: true,
                    editable: false,
                    computeOnDirty: true,
                    dependentOnFoundParam: false,
                  },
                },
                y: {
                  type: "float",
                  default_value: 0,
                  options: {
                    spare: true,
                    editable: true,
                    computeOnDirty: true,
                    dependentOnFoundParam: false,
                  },
                  raw_input: 0.27,
                },
              },
              inputs: [
                { index: 0, inputName: "x", node: "random1", output: "rand" },
              ],
              connection_points: {
                in: [
                  { name: "x", type: "float" },
                  { name: "y", type: "float" },
                ],
                out: [{ name: "val", type: "float" }],
              },
            },
            subnetOutput1: {
              type: "subnetOutput",
              inputs: [
                {
                  index: 0,
                  inputName: "baseColor",
                  node: "oklabToRgb1",
                  output: "rgb",
                },
              ],
              connection_points: {
                in: [{ name: "baseColor", type: "vec3" }],
                out: [],
              },
            },
          },
          ui: {
            constant1: { pos: [-500, 400] },
            attribute1: { pos: [-750, 650] },
            round1: { pos: [-600, 650] },
            random1: { pos: [-350, 650] },
            floatToVec2_1: { pos: [-500, 650] },
            multAdd5: { pos: [-200, 650] },
            constant2: { pos: [-500, 200] },
            rgbToOklab1: { pos: [-300, 200] },
            rgbToOklab2: { pos: [-300, 400] },
            oklabToRgb1: { pos: [200, 350] },
            mix1: { pos: [50, 300] },
            pow1: { pos: [-150, 450] },
            subnetOutput1: { pos: [400, 300] },
          },
        },
      },
    ];
    for (let polyNodeData of polyNodesData) {
      PolyNodeController.createNodeClassAndRegister(polyNodeData);
    }
    AllExpressionsRegister.run(Poly);
    configurePolygonjs(Poly);
  }

  Poly.libs.setRoot("./three/js/libs");

  function configureSceneAndOverrideAssetsRootIfRequired(scene) {
    configureScene(scene);
    if (assetsRoot) {
      scene.assets.setRoot(assetsRoot);
    }
    if (libsRootPrefix) {
      Poly.libs.setRootPrefix(libsRootPrefix);
    }
  }

  // load the scene and create a viewer
  const sceneName = "bvh_demo_lightning";
  const { scene, viewer } = await ScenePlayerImporter.loadSceneData({
    domElement,
    sceneName,
    configureScene: configureSceneAndOverrideAssetsRootIfRequired,
    sceneData,
    onProgress,
    autoPlay,
    createViewer,
    renderer,
    cameraMaskOverride,
  });
  return {
    scene,
    viewer,
  };
};

export { Poly, loadSceneFromSceneData_bvh_demo_lightning };
