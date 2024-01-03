<?php

namespace App\Http\Controllers;

use App\Http\Api\TitleObject;
use App\Models\Movie;
use Illuminate\Http\Request;

class GetTitleController extends BaseController
{
    public function getByTitle(Request $request, string $id)
    {
        $movie = Movie::findOrFail($id);

        return $this->sendResponse($request->format, new TitleObject($movie->tconst));
    }
}
