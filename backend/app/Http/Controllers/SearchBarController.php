<?php

namespace App\Http\Controllers;

use App\Http\Requests\SearchBarRequest;
use App\Http\Resources\MovieCollection;
use App\Http\Resources\PersonCollection;
use App\Http\Resources\PrincipalCollection;
use App\Models\Movie;
use App\Models\Person;
use App\Models\Principal;
use Illuminate\Http\Request;

class SearchBarController extends Controller
{
    /**
     * @OA\Get(
     *     path="/searchbar",
     *     summary="Searchbar",
     *     description="Search Media, People and Principals",
     *     operationId="searchbar",
     *     @OA\Parameter(
     *         name="searchPart",
     *         in="query",
     *         description="Searching for movies, people, principals based on typed phrase",
     *         required=true,
     *         explode=true,
     *         @OA\Schema(
     *             type="string",
     *         )
     *     ),
     *     @OA\Response(
     *         @OA\MediaType(mediaType="application/json"),
     *         response=200,
     *         description="Successful operation",
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Invalid status value"
     *     ),
     * )
     */
    public function __invoke(SearchBarRequest $request)
    {
        $request->validated();
        $searchedMovies = Movie::query();
        $queryString = $request->validated('searchPart');
        $searchedMovies->where('primaryTitle', 'LIKE', "%$queryString%");
        $searchedMedia = $searchedMovies->get();

        $searchedPeople = Person::query();
        $queryString = $request->validated('searchPart');
        $searchedPeople->where('primaryName', 'LIKE', "%$queryString%");
        $searchedPeople = $searchedPeople->get();

        $searchedPrincipals = Principal::query();
        $queryString = $request->validated('searchPart');
        $searchedPrincipals->where('characters', 'LIKE', "%$queryString%");
        $searchedPrincipals = $searchedPrincipals->get();

        return response()->json(
            [
                'movies' => new MovieCollection($searchedMedia),
                'people' => new PersonCollection($searchedPeople),
                'principals' => new PrincipalCollection($searchedPrincipals),

            ]
        );
    }
}
