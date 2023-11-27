<?php

namespace App\Http\Controllers;

use App\Enums\AkasTypeEnum;
use App\Models\Movie;
use App\Models\MovieAka;
use App\Models\Principal;
use Illuminate\Http\Request;

class GetTitleController extends BaseController
{
    public function getByTitle(Request $request, $id)
    {
        $movie = Movie::findOrFail($id);
        $aka = MovieAka::where('titleId', $movie->tconst)->get();
        $akaAlternative = MovieAka::where('titleId', $movie->tconst)->where('ordering', AkasTypeEnum::ALTERNATIVE->value)->first();
        $principals = Principal::where('tconst', $movie->tconst)->get();
        $data = [
            'titleID' => $movie->tconst,
            'type' => $movie->titleType,
            'originalTitle' => $movie->originalTitle,
            'titlePoster' => $movie->img_url_asset,
            'startYear' => $movie->startYear,
            'endYear' => $movie->endYear,
            'genres' => $movie->genres,
            //TODO: genreTitle
            'titleAkas' => implode(",", $aka->pluck('title')->toArray()),
            'akaTitle' => $akaAlternative->title,
            'regionAbbrev' => $akaAlternative->region,


        ];
        return $this->sendResponse($request->format, $data);

        dd(Movie::findOrFail($id));
    }
}
