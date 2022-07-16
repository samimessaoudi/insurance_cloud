// TODO: Watch For GitHub API client for GitHub Actions Release GA
import * as cors from "cors"; // Remove On Using Firebase Functions V2
import { App, createNodeMiddleware } from "octokit";
import * as express from 'express';
import { firestore, projectManagement } from "firebase-admin";
import * as functions from "firebase-functions/v1";
import { HttpsError } from "firebase-functions/v1/auth";
import * as functionsV2 from "firebase-functions/v2";
import { ProjectsClient } from "@google-cloud/resource-manager";
import { ResourceSettingsServiceClient } from "@google-cloud/resource-settings";
import { firebase } from "@googleapis/firebase";
import { androidpublisher } from "@googleapis/androidpublisher";

const GITHUB_APP_ID = '';
const GITHUB_APP_PRIVATE_KEY = '';
const GITHUB_WEBHOOKS_SECRET = '';

const projectsClient = new ProjectsClient();
const resourceSettingsServiceClient = new ResourceSettingsServiceClient();
const firebaseClient = firebase("v1beta1");
const db = firestore();
const pm = projectManagement();
const androidPublisher = androidpublisher("v3");
const expressApp = express();
const octokitApp = new App({
  appId: GITHUB_APP_ID,
  privateKey: GITHUB_APP_PRIVATE_KEY,
  webhooks: {
    secret: GITHUB_WEBHOOKS_SECRET
  },
  log: {
    debug: functionsV2.logger.debug,
    info: functionsV2.logger.info,
    warn: functionsV2.logger.warn,
    error: functionsV2.logger.error,
  }
})

octokitApp.webhooks.on("issues.opened", ({ octokit, payload }) => {
  // ...  
});

// *: Apps Admin Would Have An Add App Button That Installs App On His Specified Repo And Returnes Tokens To Us

expressApp.use(createNodeMiddleware(octokitApp));

export const octokitAppFunction = functions.https.onRequest(expressApp);

export const createDeployment = functions.https.onCall(async (data, context) => {
  const githubAppInstallationId = 123; // Get From Firestore
  const productOctokit = octokitApp.getInstallationOctokit(githubAppInstallationId);
  // ...
  // Create Firebase project
  try {
    
  } catch (error) {
    
  }
});

///////////////////////
export const v2FnCallableHttp = functionsV2.https.onCall({
  cors: true,
  secrets: ["SECRET1", "SECRETN"]
}, request => {
  // Throw Errors
  if (!request.auth) {
    throw new HttpsError("failed-precondition", "....");
    
  }
  // Access Environment Variables / Secrets
  const PLANET = process.env.PLANET;
  const SECRET1 = process.env.SECRET1;
})

export const v2FnRequestHttp = functionsV2.https.onRequest({
  cors: true
}, (request, response) => {
  // ....
})

////////////////////////////
export const fnCallable = functions.runWith({ failurePolicy: true }).https.onCall(async (data, context) => {
  functions.logger.info("Hello logs!", {structuredData: true});
})

// Delete After Usage: Call Using 'curl -X POST -H "Content-Type:application/json" -H "X-MyHeader: 123" YOUR_HTTP_TRIGGER_ENDPOINT?foo=baz -d '{"text":"something"}''
// Delete After Usage: Json request body is automatically parsed using bodyParser.json and accessible using request.body.%propertyName%
// Always Terminate Functions Using send(), redirect(), or end()

////////////////////////////////////
expressApp.use(cors());

expressApp.post('/', async (request, response) => {
  functions.logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});

export const fnUsingExpress = functions.https.onRequest(expressApp);
/////////////////////
export const fnUsingCloudTasks = functions
  .runWith({
    secrets: [ '...']
  })
  .tasks
  .taskQueue({
    retryConfig: {
      maxAttempts: 5,
      maxBackoffSeconds: 60
    },
    rateLimits: {
      maxConcurrentDispatches: 6
    }
  })
  .onDispatch(async (data, context) => {

  });

  // Things Are Missing, Continue Using 'https://firebase.google.com/docs/functions/task-functions#enqueue_the_function'
/////////////////////
export const fnSchedulable = functions.pubsub.schedule('every 5 minutes').retryConfig({
  // ...
}).onRun(context => {
  // ...
});
///////////////////////

export const fnFirestore = functions.firestore.document("pathtodocumentevenwithinsubcollectionsandcanusewildcards").onWrite((snap, context) => {
  // use context.auth
  // use context.params to access matched widlcard values
  // use snap.after ofc
  // snap.after.ref.... to write data
  // use db.... to write data
}); // onCreate|onDelete|onUpdate

////////////////////////
export const fnPubSub = functions.pubsub.topic("topic-cc").onPublish((message, context) => {
  // can use context for msg metadata
  const msgObjFromJson = message.json;
  const msgObjFromBase64 = Buffer.from(message.data, 'base64').toString();
  const msgAttrs = message.attributes;
});