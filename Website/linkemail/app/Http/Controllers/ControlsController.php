<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Mail\SendMail;
use Kreait\Firebase;
use Illuminate\Support\Facades\Mail;
use Kreait\Firebase\Factory;
use Kreait\Firebase\ServiceAccount;

use Kreait\Firebase\Database;


class ControlsController extends Controller
{
    public function index(Request $request)
    {
	 
	$uid = $request->input("f");
        $serviceAccount = ServiceAccount::fromJsonFile(__DIR__.'/FirebaseKey.json');
        $firebase = (new Factory)
        ->withServiceAccount($serviceAccount)
        ->withDatabaseUri('https://emaillink-7c2d0-default-rtdb.firebaseio.com/')
        ->create(); 

        $database = $firebase->getDatabase();
        //get all data
	$nodes = $database->getReference($uid)->getvalue();      
        //Setting data to the child in firebase realtime database.
	if($nodes == NULL){
		return abort(404);
	}

        return view('controls')->with([
		'nodes' => $nodes,
		'uid' => $uid,
        ]);
    }
    public function store(Request $request) 
    {
	$this->validate($request, [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255',
	]); 	
	$uid = $request->input("f");
        $serviceAccount = ServiceAccount::fromJsonFile(__DIR__.'/FirebaseKey.json');
        $firebase = (new Factory)
        ->withServiceAccount($serviceAccount)
        ->withDatabaseUri('https://emaillink-7c2d0-default-rtdb.firebaseio.com/')
	->create(); 
	$database = $firebase->getDatabase();
	$file = $database->getReference($uid)->getvalue();
	//Setting data to the child in firebase realtime database.
	Mail::queue(new SendMail($request->input("email"), $request->input("name"), $file["filename"], $file["url"] )  );
        $setNode = $database->getReference($uid . "/emails")->push([ "email" => $request->input("email"),
								    "name" => $request->input("name")	
	]);
	return view("thankyou");
    }
}
