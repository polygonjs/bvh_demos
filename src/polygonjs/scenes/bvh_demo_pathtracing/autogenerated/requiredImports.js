// cop
import { BuilderCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/Builder";
import { EnvMapCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/EnvMap";
import { ImageCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/Image";
import { ImageEXRCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/ImageEXR";
// event
import { CameraOrbitControlsEventNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/event/CameraOrbitControls";
// mat
import { MeshStandardMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/MeshStandard";
// obj
import { CopNetworkObjNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/obj/CopNetwork";
import { GeoObjNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/obj/Geo";
// rop
import { PathTracingRendererRopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/rop/PathTracingRenderer";
// sop
import { BVHSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/BVH";
import { AreaLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/AreaLight";
import { AttribCreateSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/AttribCreate";
import { BoxSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Box";
import { CameraControlsSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/CameraControls";
import { CameraRendererSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/CameraRenderer";
import { ConeSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Cone";
import { CopySopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Copy";
import { DeleteSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Delete";
import { FileGLTFSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/FileGLTF";
import { HemisphereLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/HemisphereLight";
import { HierarchySopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Hierarchy";
import { JitterSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Jitter";
import { LineSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Line";
import { MaterialSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Material";
import { MaterialsNetworkSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/MaterialsNetwork";
import { MergeSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Merge";
import { PerspectiveCameraSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PerspectiveCamera";
import { PlaneSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Plane";
import { PlaneHelperSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PlaneHelper";
import { PointBuilderSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PointBuilder";
import { PolarTransformSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PolarTransform";
import { PolywireSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Polywire";
import { RaySopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Ray";
import { ScatterSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Scatter";
import { SubnetSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Subnet";
import { SubnetInputSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/SubnetInput";
import { SubnetOutputSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/SubnetOutput";
import { TransformSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Transform";

// named functions
import { addVector } from "@polygonjs/polygonjs/dist/src/engine/functions/addVector";
import { complement } from "@polygonjs/polygonjs/dist/src/engine/functions/complement";
import { getActorNodeParamValue } from "@polygonjs/polygonjs/dist/src/engine/functions/getActorNodeParamValue";
import { mathFloat_1 } from "@polygonjs/polygonjs/dist/src/engine/functions/mathFloat_1";
import { mathFloat_2 } from "@polygonjs/polygonjs/dist/src/engine/functions/mathFloat_2";
import { mathFloat_3 } from "@polygonjs/polygonjs/dist/src/engine/functions/mathFloat_3";
import { mathFloat_4 } from "@polygonjs/polygonjs/dist/src/engine/functions/mathFloat_4";
import { multAdd } from "@polygonjs/polygonjs/dist/src/engine/functions/multAdd";
import { smoothstep } from "@polygonjs/polygonjs/dist/src/engine/functions/smoothstep";

export const requiredImports_bvh_demo_pathtracing = {
  nodes: [
    BuilderCopNode,
    EnvMapCopNode,
    ImageCopNode,
    ImageEXRCopNode,
    CameraOrbitControlsEventNode,
    MeshStandardMatNode,
    CopNetworkObjNode,
    GeoObjNode,
    PathTracingRendererRopNode,
    BVHSopNode,
    AreaLightSopNode,
    AttribCreateSopNode,
    BoxSopNode,
    CameraControlsSopNode,
    CameraRendererSopNode,
    ConeSopNode,
    CopySopNode,
    DeleteSopNode,
    FileGLTFSopNode,
    HemisphereLightSopNode,
    HierarchySopNode,
    JitterSopNode,
    LineSopNode,
    MaterialSopNode,
    MaterialsNetworkSopNode,
    MergeSopNode,
    PerspectiveCameraSopNode,
    PlaneSopNode,
    PlaneHelperSopNode,
    PointBuilderSopNode,
    PolarTransformSopNode,
    PolywireSopNode,
    RaySopNode,
    ScatterSopNode,
    SubnetSopNode,
    SubnetInputSopNode,
    SubnetOutputSopNode,
    TransformSopNode,
  ],
  operations: [],
  jsFunctions: [
    addVector,
    complement,
    getActorNodeParamValue,
    mathFloat_1,
    mathFloat_2,
    mathFloat_3,
    mathFloat_4,
    multAdd,
    smoothstep,
  ],
};
