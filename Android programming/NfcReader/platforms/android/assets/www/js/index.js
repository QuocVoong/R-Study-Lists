/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
var app = {
    // Application Constructor
    initialize: function() {
        this.bindEvents();
        console.log("Starting NFC Reader app");
    },
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // 'load', 'deviceready', 'offline', and 'online'.
    bindEvents: function() {
        document.addEventListener('deviceready', this.onDeviceReady, false);
    },
    // deviceready Event Handler
    //
    // The scope of 'this' is the event. In order to call the 'receivedEvent'
    // function, we must explicitly call 'app.receivedEvent(...);'
    onDeviceReady: function() {
        nfc.addTagDiscoveredListener(
                 app.onNfc,             // tag successfully scanned
                 function (status) {    // listener successfully initialized
                    app.display("Tap a tag to read its id number.");
                 },
                 function (error) {     // listener fails to initialize
                    app.display("NFC reader failed to initialize " +
                       JSON.stringify(error));
                 }
        );
    },
    // Update DOM on a Received Event
    receivedEvent: function(id) {
        var parentElement = document.getElementById(id);
        var listeningElement = parentElement.querySelector('.listening');
        var receivedElement = parentElement.querySelector('.received');

        listeningElement.setAttribute('style', 'display:none;');
        receivedElement.setAttribute('style', 'display:block;');

        console.log('Received Event: ' + id);
    }
    /*
       displays tag ID from @nfcEvent in message div:
    */

       onNfc: function(nfcEvent) {
          var tag = nfcEvent.tag;
          app.display("Read tag: " + nfc.bytesToHexString(tag.id));
       },

       /*
          appends @message to the message div:
       */
       display: function(message) {
          var label = document.createTextNode(message),
             lineBreak = document.createElement("br");
          messageDiv.appendChild(lineBreak);         // add a line break
          messageDiv.appendChild(label);             // add the text
       },
       /*
          clears the message div:
       */
       clear: function() {
           messageDiv.innerHTML = "";
       }
};

app.initialize();