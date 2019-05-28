!function(n){var i={};function r(e){if(i[e])return i[e].exports;var t=i[e]={i:e,l:!1,exports:{}};return n[e].call(t.exports,t,t.exports,r),t.l=!0,t.exports}r.m=n,r.c=i,r.d=function(e,t,n){r.o(e,t)||Object.defineProperty(e,t,{enumerable:!0,get:n})},r.r=function(e){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},r.t=function(t,e){if(1&e&&(t=r(t)),8&e)return t;if(4&e&&"object"==typeof t&&t&&t.__esModule)return t;var n=Object.create(null);if(r.r(n),Object.defineProperty(n,"default",{enumerable:!0,value:t}),2&e&&"string"!=typeof t)for(var i in t)r.d(n,i,function(e){return t[e]}.bind(null,i));return n},r.n=function(e){var t=e&&e.__esModule?function(){return e.default}:function(){return e};return r.d(t,"a",t),t},r.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},r.p="",r(r.s=0)}([function(e,t,n){"use strict";var i=n(1),r=r||{};Shiny.addCustomMessageHandler("rlocker-setup",function(e){r=new i.Locker(e)}),Shiny.addCustomMessageHandler("rlocker-store",function(e){r.store(e)}),Shiny.addCustomMessageHandler("create-statement",function(e){var t=r.createBasicStatement(e.verb.display["en-US"]);r.store(t)})},function(e,t,n){"use strict";Object.defineProperty(t,"__esModule",{value:!0}),t.Locker=void 0;var i=function(){function i(e,t){for(var n=0;n<t.length;n++){var i=t[n];i.enumerable=i.enumerable||!1,i.configurable=!0,"value"in i&&(i.writable=!0),Object.defineProperty(e,i.key,i)}}return function(e,t,n){return t&&i(e.prototype,t),n&&i(e,n),e}}(),r=n(2);if("undefined"==typeof ADL)throw"Error: ADL Wrapper not defined";if(void 0===r.UUID)throw"Error: UUID Generator not defined";t.Locker=function(){function t(e){!function(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}(this,t),this.debug=!0,this.config=e||{base_url:"http://localhost:8000/xapi/",auth:"Basic "+toBase64("abcd:1234")},this.config.endpoint=(this.config.base_url+"/data/xAPI/").replace(/([^:]\/)\/+/g,"$1"),this.session={id:null,launched:null},this.agent=null,this.activity=null,this.init()}return i(t,[{key:"init",value:function(){ADL.XAPIWrapper.changeConfig(this.config),this.setSession(),this.setCurrentAgent("mailto:default@example.org"),this.setCurrentActivity(window.location.href,document.title),this.experienced_xAPI()}},{key:"setSession",value:function(){if("undefined"!=typeof Storage){var e=sessionStorage.getItem("sid");this.session.launched=!e&&(e=r.UUID.generate(),sessionStorage.setItem("sid",e),!0),this.session.id=e}else this.session.id="0000-0000-0000-0000"}},{key:"getSession",value:function(){return this.session}},{key:"store",value:function(e){this.debug?(console.info(e),ADL.XAPIWrapper.sendStatement(e,function(e,t){return 200!=e.status&&console.error(e),console.info(t),t})):ADL.XAPIWrapper.sendStatement(e)}},{key:"setCurrentAgent",value:function(e){var t=1<arguments.length&&void 0!==arguments[1]?arguments[1]:this.session.id;this.agent=new ADL.XAPIStatement.Agent(ADL.XAPIWrapper.hash(e),t)}},{key:"getCurrentAgent",value:function(){return this.agent}},{key:"setCurrentActivity",value:function(e,t){this.activity=new ADL.XAPIStatement.Activity(e,t)}},{key:"getCurrentActivity",value:function(){return this.activity}},{key:"getVerb",value:function(e,t){return new ADL.XAPIStatement.Verb(e,t)}},{key:"createBasicStatement",value:function(e){var t=1<arguments.length&&void 0!==arguments[1]?arguments[1]:"http://adlnet.gov/expapi/verbs/"+e;return new ADL.XAPIStatement(this.getCurrentAgent(),this.getVerb(t,e),this.getCurrentActivity())}},{key:"experienced_xAPI",value:function(){var e=this.session.launched?"launched":"experienced";this.store(this.createBasicStatement(e)),this.session.launched=!1}},{key:"terminated_xAPI",value:function(){this.store(this.createBasicStatement("terminated"))}},{key:"completed_xAPI",value:function(){this.store(this.createBasicStatement("completed"))}},{key:"answered_xAPI",value:function(e,t,n,i){var r=t.attempt?t.attempt:1,o=this.activity.id+"#"+e,a=this.activity.definition.name["en-US"]+" :: "+e,s=this.getCurrentAgent(),u=this.getVerb("http://adlnet.gov/expapi/verbs/answered","answered"),c=new ADL.XAPIStatement.Activity(o,a),d=new ADL.XAPIStatement(s,u,c);return d.object.definition.type="http://adlnet.gov/expapi/activities/interaction",d.object.definition.interactionType=t.interactionType,d.object.definition.correctResponsesPattern=[JSON.stringify(t.validateOn),t.answers.toString()],d.result={success:i,response:String(n),extensions:{"http://adlnet.gov/expapi/verbs/attempted":r.toString()}},this.store(d),d}},{key:"interacted_xAPI",value:function(e){var t=this.activity.id+"#"+e,n=this.activity.definition.name["en-US"]+" :: "+e,i=this.getCurrentAgent(),r=this.getVerb("http://adlnet.gov/expapi/verbs/interacted","interacted"),o=new ADL.XAPIStatement.Activity(t,n),a=new ADL.XAPIStatement(i,r,o);a.object.definition.type="http://adlnet.gov/expapi/activities/interaction",a.object.definition.interactionType="other",this.store(a)}}]),t}()},function(e,t,n){"use strict";Object.defineProperty(t,"__esModule",{value:!0});t.UUID={generate:function(){for(var e=[],t=0;t<256;t++)e[t]=(t<16?"0":"")+t.toString(16);var n=4294967295*Math.random()|0,i=4294967295*Math.random()|0,r=4294967295*Math.random()|0,o=4294967295*Math.random()|0;return e[255&n]+e[n>>8&255]+e[n>>16&255]+e[n>>24&255]+"-"+e[255&i]+e[i>>8&255]+"-"+e[i>>16&15|64]+e[i>>24&255]+"-"+e[63&r|128]+e[r>>8&255]+"-"+e[r>>16&255]+e[r>>24&255]+e[255&o]+e[o>>8&255]+e[o>>16&255]+e[o>>24&255]}}}]);