// TODO: Watch For GitHub API client for GitHub Actions Release GA
import * as cors from "cors"; // Remove On Using Firebase Functions V2
import { App, createNodeMiddleware } from "octokit";
import { GraphqlResponseError } from "@octokit/graphql"; // '@octokit/graphql' Is Not Directly Installed, So This Is A Mess, So Watch For 'GraphqlResponseError' Merge Into 'octokit' Then Delete This Import
import { StatusState } from "@octokit/graphql-schema";
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

expressApp.use(createNodeMiddleware(octokitApp));

export const octokitAppFunction = functions.https.onRequest(expressApp);

const ACTION_FILES_COMMIT_MSG_HEADLINE = 'commited action files';

// *: Apps Admin Would Have An Add App Button That Installs App On His Specified Repo And Returnes Tokens To Us
export const addApp = functions.https.onCall(async (data: Product, context) => {
  // TODO: Implement: Create Firebase Project

  try {
    // Get Product Template
    const productTemplateFiles = await octokitApp.octokit.graphql(
      `#graphql
        query get_product_template_files {
          repository {
            // TODO: Get Files Path Their Base64 Encoded Contents
            // Repo Name: samimessaoudi/product_actions
          }
        }
      `,
      {
        
      }
    );
    // Merge Product Template
    const productOctokit = await octokitApp.getInstallationOctokit(data.githubAppInstallationId);
    await productOctokit.graphql<{
      commit: {
        status: {
          state: StatusState
        }
      }
    }>(
      `#graphql
        mutation commit_action_files($expectedHeadOid: GitObjectID!, $repositoryNameWithOwner: String, $branchName: String, $headline: String!, $additions: [FileAddition!]) {
          createCommitOnBranch(
            input: {
              expectedHeadOid: $expectedHeadOid
              branch: {
                repositoryNameWithOwner: $repositoryNameWithOwner,
                branchName: $branchName
              },
              message: {
                headline: $headline
              },
              fileChanges: {
                additions: $additions
              }
            }
          ) {
            commit {
              status {
                state
              }
            }
          }
        }
      `,
      {
        "expectedHeadOid": "", // TODO: Make Random Or IDK
        "repositoryNameWithOwner": "", // ...
        "branchName": "", // ...
        "headline": ACTION_FILES_COMMIT_MSG_HEADLINE,
        "additions": productTemplateFiles.map(file => (
          {
            path: file.path,
            contents: file.contents
          }
        ))
      }
    );
    await productOctokit.graphql(
      `#graphql
        mutation merge_action_files {
          mergeBranch(
            input: {

            }
          ) {
            
          }
        }
      `,
      {

      }
    )
  } catch (error) {
    if (error instanceof GraphqlResponseError) {
      // ...
    }
    // ...
  }
});

octokitApp.webhooks.on('release', ({id, name, payload}) => { // And Children Events
  // ...
});

octokitApp.webhooks.on('workflow_job', ({id, name, payload}) => {
  // ...
});

octokitApp.webhooks.on('repository', ({id, name, payload}) => { // And Children Events
  // ...
});

octokitApp.webhooks.on('installation_repositories.added', ({id, name, payload}) => {
  // ...
});

octokitApp.webhooks.on('installation_repositories.removed', ({id, name, payload}) => {
  // TODO: Handle This
});

octokitApp.webhooks.on('github_app_authorization.revoked', ({id, name, payload}) => {
  // TODO: Handle This
});

octokitApp.webhooks.on('deployment.created', ({id, name, payload}) => {
  // ...
});

const ISSUE_TEMPLATE = ''; // TODO: ...

export const saveIssue = functions.https.onCall(async (data: Issue, context) => {
  // TODO: Get Repository Global Node ID
  octokitApp.octokit.rest.repos........
  if (data.id != null) {
    return octokitApp.octokit.graphql<{
      issue: {
        id: String
      }
    }>(
      `#graphql
        mutation update_issue($id: ID!, $title: String, $body: String) {
          updateIssue(
            input: {
              id: $id
              title: $title,
              body: $body
            }
          ) {
            issue {
              id
            }
          }
        }
      `,
      {
        "repositoryId": data.product,
        "issueTemplate": ISSUE_TEMPLATE,
        "title": data.title,
        "body": data.body
      }
    );
  }

  return octokitApp.octokit.graphql<{
    issue: {
      id: String
    }
  }>(
    `#graphql
      mutation create_issue($repositoryId: ID!, $issueTemplate: String, $title: String!, $body: String) {
        createIssue(
          input: {
            repositoryId: $repositoryId,
            issueTemplate: $issueTemplate,
            title: $title,
            body: $body
          }
        ) {
          issue {
            id
          }
        }
      }
    `,
    {
      "repositoryId": "", // TODO: ...
      "issueTemplate": ISSUE_TEMPLATE,
      "title": data.title,
      "body": data.body
    }
  );
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