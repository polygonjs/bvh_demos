// cop
import { SDFExporterCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/SDFExporter";
import { SDFFromObjectCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/SDFFromObject";
import { SDFFromUrlCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/SDFFromUrl";
import { EnvMapCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/EnvMap";
import { ImageEXRCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/ImageEXR";
// event
import { CameraOrbitControlsEventNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/event/CameraOrbitControls";
// mat
import { MeshStandardMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/MeshStandard";
import { RayMarchingBuilderMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/RayMarchingBuilder";
// obj
import { CopNetworkObjNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/obj/CopNetwork";
import { GeoObjNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/obj/Geo";
// rop
import { WebGLRendererRopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/rop/WebGLRenderer";
// sop
import { BoxSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Box";
import { BoxLinesSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/BoxLines";
import { CameraControlsSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/CameraControls";
import { CameraRendererSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/CameraRenderer";
import { CopNetworkSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/CopNetwork";
import { FileGLTFSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/FileGLTF";
import { HemisphereLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/HemisphereLight";
import { MaterialSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Material";
import { MaterialsNetworkSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/MaterialsNetwork";
import { MergeSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Merge";
import { PerspectiveCameraSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PerspectiveCamera";

export const requiredImports_bvh_demo_sdf = {
  nodes: [
    SDFExporterCopNode,
    SDFFromObjectCopNode,
    SDFFromUrlCopNode,
    EnvMapCopNode,
    ImageEXRCopNode,
    CameraOrbitControlsEventNode,
    MeshStandardMatNode,
    RayMarchingBuilderMatNode,
    CopNetworkObjNode,
    GeoObjNode,
    WebGLRendererRopNode,
    BoxSopNode,
    BoxLinesSopNode,
    CameraControlsSopNode,
    CameraRendererSopNode,
    CopNetworkSopNode,
    FileGLTFSopNode,
    HemisphereLightSopNode,
    MaterialSopNode,
    MaterialsNetworkSopNode,
    MergeSopNode,
    PerspectiveCameraSopNode,
  ],
  operations: [],
  jsFunctions: [],
};
