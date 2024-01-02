<?php

namespace App\Http\Controllers;

use App\Http\Resources\MovieCollection;
use App\Http\Resources\MovieResource;
use App\Models\Movie;
use Illuminate\Http\Request;

class MovieController extends Controller
{
    public function getStartedMovies()
    {
        return new MovieCollection(Movie::with('rating')->inRandomOrder()->limit(5)->get());
    }

    public function getMovieById(Movie $movie)
    {
        return new MovieResource($movie->loadMissing(['rating', 'principals.person', 'alternativeTitles']));
    }
}
