<?php

namespace App\Http\Controllers;

use App\Http\Api\TitleObject;
use App\Http\Requests\SearchTitleRequest;
use App\Models\Movie;
use Illuminate\Http\Request;

class SearchTitleController extends Controller
{
    // public function __construct(private TitleObject $titleObject)
    // {
    // }
    /**
     * Handle the incoming request.
     */
    public function __invoke(SearchTitleRequest $request)
    {
        $request->validated();
        $builder = Movie::query();

        $queryString = $request->validated('titlePart');
        $builder->where('primaryTitle', 'LIKE', "%$queryString%");
        $searchedMedia = $builder->get();
        $result = [];
        foreach ($searchedMedia as $movie) {
            // $result[] = $this->titleObject->prepareData($movie->tconst);
        }
        return  $result;
    }
}
