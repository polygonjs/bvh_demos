//
// learn more about this file on https://polygonjs.com/docs/editor/config
//

import {
	EditorApiOptions,
	ConfigureEditor,
	// @ts-ignore
} from "polygonjs-editor/public/editor/api";

export const configureEditor: ConfigureEditor = (options: EditorApiOptions) => {
	//
	// **********************
	// Add custom javascript to the editor
	// **********************
	//
	// options.api.html.head.addScript({
	// 	id: 'my-script',
	// 	content: `alert('this is running my custom script')`,
	// });
	//
	//
	//
	//
	// **********************
	// setup a post-export command,
	// this is typically used to publish your files online
	// **********************
	//
	// options.api.export.setPostExportCommand((args)=>{
	// 	const {exportFolder, sceneName} = args;
	// 	// This command uses aws cli (https://docs.aws.amazon.com/cli/index.html)
	// 	// to copy the exported files on an s3 bucket and making them publicly available.
	// 	// This is used to easily export for sites builder like: Webflow, Squarespace, Wix, Bubble.
	// 	const awsS3Config = {
	// 		bucket: 'my-s3-bucket',
	// 		region: 'eu-west-2',
	// 		folder: 'my-project/polygonjs/scenes',
	// 		version: '01'
	// 	}
	// 	return {
	// 		// this is the command that is run once the export is completed
	// 		command: `aws s3 cp '${exportFolder}' 's3://${awsS3Config.bucket}/${awsS3Config.folder}/${sceneName}/v${awsS3Config.version}' --acl public-read --recursive`,
	// 		// publicPath is needed when importscript the javascript from another site, so it knows where all other files can be fetched from
	// 		publicPath: `https://${awsS3Config.bucket}.s3.${awsS3Config.region}.amazonaws.com/${awsS3Config.folder}/${sceneName}/v${awsS3Config.version}/`
	// 	}
	// });
	//
	//
	//
	// **********************
	// Start A Multiplayer Session
	// **********************
	//
	//
	// learn more https://polygonjs.com/docs/multiplayer
	//
	// options.api.multiplayer.remote.ngrok.setAuthToken("YOUR-AUTHTOKEN");
	// options.api.multiplayer.remote.ngrok.setCloseExistingTunnelsOnCreate(true);
	//
};
