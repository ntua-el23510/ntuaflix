<?php

use App\Http\Controllers\ByGenreTitleController;
use App\Http\Controllers\GetContributorByNameController;
use App\Http\Controllers\GetTitleController;
use App\Http\Controllers\MovieController;
use App\Http\Controllers\SearchContributorNameController;
use App\Http\Controllers\SearchTitleController;
use App\Http\Controllers\UserAuthController;
use App\Http\Controllers\UserController;
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
    Route::controller(MovieController::class)->group(function () {
        Route::get('/movies/get-started-movies', 'getStartedMovies');
        Route::get('/movies/{movie}', 'getMovieById');
    });
    Route::controller(UserAuthController::class)->prefix('auth')->group(function () {
        Route::post('/register', 'register');
        Route::post('/login', 'login');
    });
    Route::get('title/{title_id}', [GetTitleController::class, 'getByTitle']);
    Route::get('/searchtitle', SearchTitleController::class);
    Route::get('/bygenre', ByGenreTitleController::class);
    Route::get('/name/{name_id}', GetContributorByNameController::class);
    Route::get('/searchname', SearchContributorNameController::class);
});
Route::prefix('ntuaflix_api')->middleware('auth:sanctum')->group(function () {
    Route::controller(UserAuthController::class)->prefix('auth')->group(function () {
        Route::post('/logout', 'logout');
        Route::get('/user', 'user');
    });
    Route::controller(UserController::class)->group(function () {
        Route::put('/user/assign-movie-status', 'assignMovieStatus');
    });
    Route::post('/movies/{movie}/add-rating', [MovieController::class, 'addRating']);
});
