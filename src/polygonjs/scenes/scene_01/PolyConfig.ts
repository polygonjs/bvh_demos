import { PolyEngine } from "@polygonjs/polygonjs/dist/src/engine/Poly";
import { PolyScene } from "@polygonjs/polygonjs/dist/src/engine/scene/PolyScene";

export function configurePolygonjs(poly: PolyEngine) {
	// we have a `console.log` here to avoid errors like 'poly is declared but not used' at build time
	console.log("poly", poly);
	//
	//
	// You can configure Polygonjs here:
	//
	//
	//
	// # 1. Import plugins
	//
	// Plugins are a way to add your own nodes to Polygonjs,
	// which allow you to extend its capabilities.
	// See https://github.com/polygonjs/plugins_tutorials
	//
	//
	//
	// # 2. Configure Mapbox:
	//
	// If you use Mapbox nodes, you need to add your Mapbox token. Follow those steps:
	// 1. Find your mapbox token from your account at: https://account.mapbox.com/
	// 2. replace the 'XXXXXX' below by your token and uncomment the line.
	//
	// poly.thirdParty.mapbox().setToken('XXXXXX');
	//
	//
	//
}

export function configureScene(scene: PolyScene) {
	// we have a `console.log` here to avoid errors like 'scene is declared but not used' at build time
	console.log("scene", scene);
	//
	//
	// You can configure the scene here:
	// https://polygonjs.com/docs/api
	//
	// ensure frame is set to 0 at start time:
	// scene.setFrame(0);
}
