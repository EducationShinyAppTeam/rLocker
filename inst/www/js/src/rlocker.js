/**
 * rlocker - An xAPI Statement Generator & Storage Mechanism
 * @author Bob Carey (https://github.com/rpc5102).
 * @license GPL-3.0+
 **/

import { UUID } from './uuid.js';

/**
 * This class requires the following modules:
 * {@link https://github.com/adlnet/xAPIWrapper}
 * @requires xapiwrapper/adl
 * @requires uuid/generator
 **/

/* Check that requirements are met. */
if (typeof ADL == "undefined") {
  throw "Error: ADL Wrapper not defined";
} else if (typeof UUID == "undefined") {
  throw "Error: UUID Generator not defined";
}

/**
 * Creates a new Learning Locker instance.
 * @class rlocker/Locker
 * @see module:rlocker/Locker
 */
export class Locker {

  constructor(config) {
    this.debug = true,
    this.config = config ? config : {
      base_url: 'http://localhost:8000/xapi/',
      auth: 'Basic ' + toBase64('abcd:1234'),
    },
    this.config.endpoint = (this.config.base_url + '/data/xAPI/').replace(/([^:]\/)\/+/g, "$1"),
    this.session = {
      id: null,
      launched: null
    },
    this.agent = null,
    this.activity = null,

    this.init();
  }

  init() {
    ADL.XAPIWrapper.changeConfig(this.config);

    this.setSession();
    this.setCurrentAgent("mailto:default@example.org");
    this.setCurrentActivity(window.location.href, document.title);
    
    this.experienced_xAPI();
  }

  setSession() {
    // Set session id
    let sid = "0000-0000-0000-0000";
    try {
      sid = ADL.XAPIWrapper.lrs.agent.name;  
    } catch(e) {
      if(e instanceof ReferenceError) {
        sid = UUID.generate();  
      }
    }
    
    // Try storing session id in sessionStorage
    if (typeof Storage !== "undefined") {
      
      // Get stored session id
      let ssid = sessionStorage.getItem("sid");
      
      // Check if stored id matches the one we have
      if (sid != ssid) {
        sessionStorage.setItem("sid", sid);
        this.session.launched = true;
      } else {
        this.session.launched = false;
      }
    } else {
      // If we can't store the info assume each session is new
      this.session.launched = true;
    }
    this.session.id = sid;
  }

  getSession() {
    return this.session;
  }

  store(statement) {
    let debug = this.debug;
    ADL.XAPIWrapper.sendStatement(statement, function (request, response) {
      if (debug) {
        request.status != 200 ? console.error(request) : console.info(response);
      }
      Shiny.onInputChange("storageStatus", request.status);
      return response;
    });
  }

  setCurrentAgent(mbox, name = this.session.id) {
    this.agent = new ADL.XAPIStatement.Agent(
      ADL.XAPIWrapper.hash(mbox),
      name
    );
  }

  getCurrentAgent() {
    return this.agent;
  }

  setCurrentActivity(href, title) {
    this.activity = new ADL.XAPIStatement.Activity(href, title);
  }

  getCurrentActivity() {
    return this.activity;
  }

  getVerb(ref, verb) {
    return new ADL.XAPIStatement.Verb(ref, verb);
  }

  createBasicStatement(verb, ref = "http://adlnet.gov/expapi/verbs/" + verb) {
    let statement = new ADL.XAPIStatement(
      this.getCurrentAgent(),
      this.getVerb(ref, verb),
      this.getCurrentActivity()
    );

    return statement;
  }

  /* @todo: ignoring passed agent values for now */
  createStatement(values) {
    let statement = new ADL.XAPIStatement(
      this.getCurrentAgent(),
      new ADL.XAPIStatement.Verb(values.verb),
      new ADL.XAPIStatement.Activity(values.object)
    );

    statement.result = values.result;

    return statement;
  }

  experienced_xAPI() {
    let verb = this.session.launched ? "launched" : "experienced";
    this.store(this.createBasicStatement(verb));

    this.session.launched = false;
  }

  terminated_xAPI() {
    this.store(this.createBasicStatement("terminated"));
  }

  completed_xAPI() {
    this.store(this.createBasicStatement("completed"));
  }

  answered_xAPI(question, data, answered, success) {
    let attempt = data.attempt ? data.attempt : 1;
    let location = this.activity.id + "#" + question;
    let title = this.activity.definition.name['en-US'] + " :: " + question;
    let agent = this.getCurrentAgent();
    let verb = this.getVerb(
      "http://adlnet.gov/expapi/verbs/answered",
      "answered"
    );
    let activity = new ADL.XAPIStatement.Activity(location, title);
    let statement = new ADL.XAPIStatement(agent, verb, activity);

    statement.object.definition.type =
      "http://adlnet.gov/expapi/activities/interaction";
    statement.object.definition.interactionType = data.interactionType;
    statement.object.definition.correctResponsesPattern = [
      JSON.stringify(data.validateOn),
      data.answers.toString()
    ];

    statement.result = {
      success: success,
      response: String(answered),
      extensions: {
        "http://adlnet.gov/expapi/verbs/attempted": attempt.toString()
      }
    };

    this.store(statement);

    return statement;
  }

  interacted_xAPI(element) {
    let location = this.activity.id + "#" + element;
    let title = this.activity.definition.name['en-US'] + " :: " + element;
    let agent = this.getCurrentAgent();
    let verb = this.getVerb(
      "http://adlnet.gov/expapi/verbs/interacted",
      "interacted"
    );
    let activity = new ADL.XAPIStatement.Activity(location, title);
    let statement = new ADL.XAPIStatement(agent, verb, activity);

    statement.object.definition.type =
      "http://adlnet.gov/expapi/activities/interaction";
    statement.object.definition.interactionType = "other";

    this.store(statement);
  }
}
