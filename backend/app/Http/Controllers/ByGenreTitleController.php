<?php

namespace App\Http\Controllers;

use App\Http\Api\TitleObject;
use App\Http\Requests\ByGenreRequest;
use App\Models\Movie;
use Illuminate\Http\Request;

class ByGenreTitleController extends BaseController
{
    /**
     * Handle the incoming request.
     */
    public function __invoke(ByGenreRequest $request)
    {
        $builder = Movie::query()->with('rating');
        $genreRequest = $request->validated('qgenre');
        $ratingRequest = $request->validated('minrating');
        $builder->where('genres', 'LIKE', "%$genreRequest%");
        $builder->whereRelation('rating', 'averageRating', '>=', $ratingRequest);
        $yrFrom = $request->validated('yrFrom');
        $yrTo = $request->validated('yrTo');
        if ($yrFrom && $yrTo) {
            $builder->whereBetween('startYear', [$yrFrom, $yrTo]);
        }

        $result = [];
        foreach ($builder->get() as $movie) {
            $result[] = new TitleObject($movie->tconst);
        }

        return $this->sendResponse($request->format, $result);
    }
}
