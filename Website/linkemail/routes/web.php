<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', 'ControlsController@index')->name('controls');
Route::post('/store', 'ControlsController@store')->name('store');

Route::get('firebase','FirebaseController@index');
Route::get('firebase-get-data', 'FirebaseController@getData');
