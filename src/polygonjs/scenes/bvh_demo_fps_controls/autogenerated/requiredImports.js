// cop
import { EnvMapCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/EnvMap";
import { ImageCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/Image";
import { ImageEXRCopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/cop/ImageEXR";
// event
import { CameraOrbitControlsEventNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/event/CameraOrbitControls";
import { FirstPersonControlsEventNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/event/FirstPersonControls";
// mat
import { MeshStandardMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/MeshStandard";
import { MeshStandardBuilderMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/MeshStandardBuilder";
import { SkyMatNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/mat/Sky";
// obj
import { CopNetworkObjNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/obj/CopNetwork";
import { GeoObjNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/obj/Geo";
// sop
import { BVHSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/BVH";
import { BVHVisualizerSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/BVHVisualizer";
import { WFCBuilderSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/WFCBuilder";
import { WFCDebugSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/WFCDebug";
import { WFCRuleConnectionFromSideNameSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/WFCRuleConnectionFromSideName";
import { WFCRuleConnectionToGridBorderSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/WFCRuleConnectionToGridBorder";
import { WFCRuleTileWeightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/WFCRuleTileWeight";
import { WFCSolverSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/WFCSolver";
import { WFCTileEmptyObjectSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/WFCTileEmptyObject";
import { WFCTileErrorObjectSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/WFCTileErrorObject";
import { WFCTilePropertiesSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/WFCTileProperties";
import { WFCTileSideNameSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/WFCTileSideName";
import { WFCTileUnresolvedObjectSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/WFCTileUnresolvedObject";
import { AttribCreateSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/AttribCreate";
import { AttribPromoteSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/AttribPromote";
import { BoxSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Box";
import { CameraControlsSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/CameraControls";
import { CopySopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Copy";
import { EmptyObjectSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/EmptyObject";
import { FileGLTFSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/FileGLTF";
import { HemisphereLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/HemisphereLight";
import { HexagonsSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Hexagons";
import { HierarchySopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Hierarchy";
import { MaterialSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Material";
import { MaterialsNetworkSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/MaterialsNetwork";
import { MergeSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Merge";
import { ObjectPropertiesSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/ObjectProperties";
import { PerspectiveCameraSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PerspectiveCamera";
import { PlaneSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Plane";
import { PolarTransformSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/PolarTransform";
import { QuadPlaneSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/QuadPlane";
import { QuadSmoothSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/QuadSmooth";
import { QuadTriangulateSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/QuadTriangulate";
import { QuadrangulateSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Quadrangulate";
import { SphereSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Sphere";
import { SpotLightSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/SpotLight";
import { TransformSopNode } from "@polygonjs/polygonjs/dist/src/engine/nodes/sop/Transform";

export const requiredImports_bvh_demo_fps_controls = {
  nodes: [
    EnvMapCopNode,
    ImageCopNode,
    ImageEXRCopNode,
    CameraOrbitControlsEventNode,
    FirstPersonControlsEventNode,
    MeshStandardMatNode,
    MeshStandardBuilderMatNode,
    SkyMatNode,
    CopNetworkObjNode,
    GeoObjNode,
    BVHSopNode,
    BVHVisualizerSopNode,
    WFCBuilderSopNode,
    WFCDebugSopNode,
    WFCRuleConnectionFromSideNameSopNode,
    WFCRuleConnectionToGridBorderSopNode,
    WFCRuleTileWeightSopNode,
    WFCSolverSopNode,
    WFCTileEmptyObjectSopNode,
    WFCTileErrorObjectSopNode,
    WFCTilePropertiesSopNode,
    WFCTileSideNameSopNode,
    WFCTileUnresolvedObjectSopNode,
    AttribCreateSopNode,
    AttribPromoteSopNode,
    BoxSopNode,
    CameraControlsSopNode,
    CopySopNode,
    EmptyObjectSopNode,
    FileGLTFSopNode,
    HemisphereLightSopNode,
    HexagonsSopNode,
    HierarchySopNode,
    MaterialSopNode,
    MaterialsNetworkSopNode,
    MergeSopNode,
    ObjectPropertiesSopNode,
    PerspectiveCameraSopNode,
    PlaneSopNode,
    PolarTransformSopNode,
    QuadPlaneSopNode,
    QuadSmoothSopNode,
    QuadTriangulateSopNode,
    QuadrangulateSopNode,
    SphereSopNode,
    SpotLightSopNode,
    TransformSopNode,
  ],
  operations: [],
  jsFunctions: [],
};
