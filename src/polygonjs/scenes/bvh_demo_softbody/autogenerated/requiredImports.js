// cop
import { EnvMapCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/EnvMap";
import { ImageCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/Image";
import { ImageEXRCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/ImageEXR";
// event
import { CameraOrbitControlsEventNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/event/CameraOrbitControls";
// mat
import { MeshStandardMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/MeshStandard";
import { MeshStandardBuilderMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/MeshStandardBuilder";
import { SkyMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/Sky";
// obj
import { CopNetworkObjNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/obj/CopNetwork";
import { GeoObjNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/obj/Geo";
// sop
import { ActorSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Actor";
import { AreaLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/AreaLight";
import { BoxSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Box";
import { CameraControlsSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/CameraControls";
import { FileFBXSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/FileFBX";
import { FuseSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Fuse";
import { HemisphereLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/HemisphereLight";
import { HierarchySopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Hierarchy";
import { MaterialSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Material";
import { MaterialsNetworkSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/MaterialsNetwork";
import { MergeSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Merge";
import { PerspectiveCameraSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PerspectiveCamera";
import { PolarTransformSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PolarTransform";
import { SphereSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Sphere";
import { SpotLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/SpotLight";
import { TetSoftBodySolverSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/TetSoftBodySolver";
import { TetTriangulateSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/TetTriangulate";
import { TetrahedralizeSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Tetrahedralize";
import { TransformSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Transform";

// named functions
import { SDFPlane } from "@polygonjs/polygonjs/dist/src/engine/functions/SDFPlane";
import { computeVelocity } from "@polygonjs/polygonjs/dist/src/engine/functions/computeVelocity";
import { globalsTime } from "@polygonjs/polygonjs/dist/src/engine/functions/globalsTime";
import { globalsTimeDelta } from "@polygonjs/polygonjs/dist/src/engine/functions/globalsTimeDelta";
import { softBodySolverStepSimulation } from "@polygonjs/polygonjs/dist/src/engine/functions/softBodySolverStepSimulation";

export const requiredImports_bvh_demo_softbody = {
  nodes: [
    EnvMapCopNode,
    ImageCopNode,
    ImageEXRCopNode,
    CameraOrbitControlsEventNode,
    MeshStandardMatNode,
    MeshStandardBuilderMatNode,
    SkyMatNode,
    CopNetworkObjNode,
    GeoObjNode,
    ActorSopNode,
    AreaLightSopNode,
    BoxSopNode,
    CameraControlsSopNode,
    FileFBXSopNode,
    FuseSopNode,
    HemisphereLightSopNode,
    HierarchySopNode,
    MaterialSopNode,
    MaterialsNetworkSopNode,
    MergeSopNode,
    PerspectiveCameraSopNode,
    PolarTransformSopNode,
    SphereSopNode,
    SpotLightSopNode,
    TetSoftBodySolverSopNode,
    TetTriangulateSopNode,
    TetrahedralizeSopNode,
    TransformSopNode,
  ],
  operations: [],
  jsFunctions: [
    SDFPlane,
    computeVelocity,
    globalsTime,
    globalsTimeDelta,
    softBodySolverStepSimulation,
  ],
};
