<?php

use App\Http\Controllers\ByGenreTitleController;
use App\Http\Controllers\GetTitleController;
use App\Http\Controllers\SearchTitleController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::prefix('ntuaflix_api')->group(function () {
    Route::get('title/{title_id}', [GetTitleController::class, 'getByTitle']);
    Route::get('/searchtitle', SearchTitleController::class);
    Route::get('/bygenre', ByGenreTitleController::class);
});
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
