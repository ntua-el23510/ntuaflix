<?php

namespace App\Http\Controllers;

use App\Http\Requests\AssignMovieStatusRequest;
use App\Http\Resources\UserResource;
use App\Models\Movie;
use App\Services\MovieService;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function __construct(private MovieService $movieService)
    {
    }

    public function assignMovieStatus(AssignMovieStatusRequest $request)
    {
        $this->movieService->assignStatus($request->validated(), $request->user());
        return new UserResource(auth()->user()->loadMissing(['toWatchMovies', 'viewedMovies']));
    }
}
