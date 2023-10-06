import { LoadedData } from "./loadScene";

interface LoadSceneAndMountOptions {
  domElement?: string | undefined;
  publicPath: string;
  onProgress: (progress: number) => void;
}

type LoadSceneAndMount_bvh_demo_pathtracing = (
  options: LoadSceneAndMountOptions
) => Promise<LoadedData>;

export const loadSceneAndMount_bvh_demo_pathtracing: LoadSceneAndMount_bvh_demo_pathtracing;
