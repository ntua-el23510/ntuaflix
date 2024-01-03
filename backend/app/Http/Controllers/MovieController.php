<?php

namespace App\Http\Controllers;

use App\Http\Requests\AddRatingRequest;
use App\Http\Requests\AssignMovieStatusRequest;
use App\Http\Resources\MovieCollection;
use App\Http\Resources\MovieResource;
use App\Models\Movie;
use App\Services\MovieService;
use Illuminate\Http\Request;

class MovieController extends Controller
{
    public function __construct(private MovieService $movieService)
    {
    }
    public function getStartedMovies()
    {
        return new MovieCollection(Movie::with('rating')->inRandomOrder()->limit(10)->get());
    }

    public function getMovieById(Movie $movie)
    {
        return new MovieResource($movie->loadMissing(['rating', 'principals.person', 'alternativeTitles', 'reviews']));
    }

    public function addRating(AddRatingRequest $addRatingRequest, Movie $movie)
    {
        $this->movieService->addRating($addRatingRequest->validated(), $movie);
        return new MovieResource($movie->loadMissing(['rating', 'principals.person', 'alternativeTitles', 'reviews']));
    }
}
