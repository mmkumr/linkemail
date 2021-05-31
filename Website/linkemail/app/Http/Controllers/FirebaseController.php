<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Kreait\Firebase;

use Kreait\Firebase\Factory;
use Kreait\Firebase\ServiceAccount;

use Kreait\Firebase\Database;


class FirebaseController extends Controller
{
    // -------------------- [ Insert Data ] ------------------
    public function index() {

        $serviceAccount = ServiceAccount::fromJsonFile(__DIR__.'/FirebaseKey.json');
        $firebase = (new Factory)
        ->withServiceAccount($serviceAccount)
        ->withDatabaseUri('https://emaillink-7c2d0-default-rtdb.firebaseio.com/')
        ->create();

        $database = $firebase->getDatabase();

        $createPost = $database
        ->getReference('node2')
        ->set(true);
            
        echo '<pre>';
        print_r($createPost->getvalue());
        echo '</pre>';

    }

    // --------------- [ Listing Data ] ------------------
    public function getData() {
        $serviceAccount = ServiceAccount::fromJsonFile(__DIR__.'/FirebaseKey.json');
        $firebase = (new Factory)
        ->withServiceAccount($serviceAccount)
        ->withDatabaseUri('https://emaillink-7c2d0-default-rtdb.firebaseio.com/')
        ->create();

    $database   =   $firebase->getDatabase();
    //blog/posts
        $createPost = $database->getReference('')->getvalue();      
        return response()->json($createPost);
    }
}
