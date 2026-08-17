___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_cmpstack_consent",
  "version": 1,
  "securityGroups": [],
  "displayName": "CMPStack Cookie Consent",
  "categories": ["TAG_MANAGEMENT", "PERSONALIZATION"],
  "brand": {
    "id": "brand_cmpstack",
    "displayName": "CMPStack",
    "thumbnail": "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 64 64'%3E%3Crect width='64' height='64' rx='12' fill='%230f172a'/%3E%3Ctext x='32' y='40' text-anchor='middle' font-size='28' fill='white' font-family='sans-serif'%3EC%3C/text%3E%3C/svg%3E"
  },
  "description": "Loads the CMPStack cookie consent banner so Google tags can wait for visitor choice. Place this tag on Consent Initialization - All Pages. Requires a CMPStack Domain ID from the dashboard.",
  "containerContexts": ["WEB"]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "domainId",
    "displayName": "CMPStack Domain ID",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "Find this in your CMPStack dashboard → domain → Install. Use the same value as the embed snippet’s data-domain-id attribute.",
    "alwaysInSummary": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const injectScript = require('injectScript');
const queryPermission = require('queryPermission');
const encodeUriComponent = require('encodeUriComponent');
const getType = require('getType');
const makeString = require('makeString');

const domainId = makeString(data.domainId || '');

if (getType(domainId) !== 'string' || domainId.length < 1) {
  data.gtmOnFailure();
  return;
}

const url =
  'https://consently.app/consent.js?v=4&domainId=' +
  encodeUriComponent(domainId);

if (!queryPermission('inject_script', url)) {
  data.gtmOnFailure();
  return;
}

injectScript(url, data.gtmOnSuccess, data.gtmOnFailure, url);


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://consently.app/consent.js*"
              },
              {
                "type": 1,
                "string": "https://*.consently.app/consent.js*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Injects consent.js when Domain ID is set
  code: |-
    mock('queryPermission', () => true);
    mock('injectScript', (url, onSuccess) => {
      onSuccess();
    });

    runCode({
      domainId: 'domain_test123'
    });

    assertApi('injectScript').wasCalled();
    assertApi('gtmOnSuccess').wasCalled();
    assertApi('gtmOnFailure').wasNotCalled();
- name: Fails when Domain ID is missing
  code: |-
    runCode({});

    assertApi('injectScript').wasNotCalled();
    assertApi('gtmOnFailure').wasCalled();
setup: ''


___NOTES___

CMPStack Community Template for Google Tag Manager.

Setup
1. Add this tag from the Community Template Gallery (or import template.tpl).
2. Paste your CMPStack Domain ID from the dashboard → domain → Install.
3. Trigger: Consent Initialization - All Pages.
4. Publish. Confirm with the CMPStack Consent Mode checker.

The template only injects https://consently.app/consent.js. Self-hosted CMPStack
installs should fork this repository and add your origin to inject_script URLs.
