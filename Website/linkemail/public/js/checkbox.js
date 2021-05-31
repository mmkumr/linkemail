// Your web app's Firebase configuration
var firebaseConfig = {
	apiKey: "AIzaSyC8svn37YI1eVl_ZyZdsM4G4Ew1vceg2D8",
	authDomain: "emaillink-7c2d0.firebaseapp.com",
	databaseURL: "https://emaillink-7c2d0-default-rtdb.firebaseio.com",
	projectId: "emaillink-7c2d0",
	storageBucket: "emaillink-7c2d0.appspot.com",
	messagingSenderId: "206702722668",
	appId: "1:206702722668:web:e21dda53b858dc881d6249",
	measurementId: "G-BS0WEBZECW"
};
// Initialize Firebase
firebase.initializeApp(firebaseConfig);
var database = firebase.database();
var ref = database.ref("/");


update = function(id, val){ 
    ref = database.ref(id);
    ref.on("value", function(snapshot) {
            var data = {};
            console.log(snapshot.val()["status"]);
            if(snapshot.val()["status"] == "ok"){
                document.getElementById("dot" + id).style.backgroundColor = "rgb(255,0,0)";
                console.log("Device is running..");
                setTimeout(function (){
                    data["status"] = "";
                    ref = database.ref(id);
                    ref.update(data);
                }, 1000); 
            } else{
                document.getElementById("dot" + id).style.backgroundColor = "rgb(187, 187, 187)";
                console.log("Device is not running..");
            }
        }, function (errorObject) {
            console.log("The read failed: " + errorObject.code);
    });

    jQuery(document).ready(function(){
        jQuery('#' + id).change(function(){     
            var data = {};
            if(document.getElementById(id).checked) {
                data["value"] = "true";
            }else {
                data["value"] = "false";
            } 
            ref = database.ref(id);
            ref.update(data);
        });
    })
}
