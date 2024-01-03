<?php

namespace App\Http\Controllers;

use App\Http\Requests\AddRatingRequest;
use App\Http\Resources\MovieCollection;
use App\Http\Resources\MovieResource;
use App\Models\Movie;
use App\Services\MovieService;

class MovieController extends Controller
{
    public function __construct(private MovieService $movieService)
    {
    }

    /**
     * @OA\Get(
     *     path="/movies/get-started-movies",
     *     tags={"Media"},
     *     summary="Get list of movies",
     *     description="Returns a 10 random movies",
     *     operationId="getRandomMovies",
     *     @OA\Response(
     *         response=200,
     *         description="Successful operation",
     *     )
     * )
     *
     * @param MovieCollection $movies
     */
    public function getStartedMovies()
    {
        return new MovieCollection(Movie::with('rating')->whereNotNull('img_url_asset')->inRandomOrder()->limit(10)->get());
    }

    /**
     * @OA\Get(
     *     path="/movies/{movie}",
     *     tags={"Media"},
     *     summary="Find movie by ID",
     *     description="Returns a single movie",
     *     operationId="getMovieById",
     *     @OA\Parameter(
     *         name="movie",
     *         in="path",
     *         description="ID of movie to return",
     *         required=true,
     *         @OA\Schema(
     *             type="string",
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="successful operation",
     *         @OA\JsonContent(ref="#/components/schemas/Movie"),
     *         @OA\XmlContent(ref="#/components/schemas/Movie"),
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Movie not found"
     *     )
     * )
     *
     * @param int $id
     */
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
