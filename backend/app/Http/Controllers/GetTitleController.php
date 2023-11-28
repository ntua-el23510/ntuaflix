<?php

namespace App\Http\Controllers;

use App\Enums\AkasTypeEnum;
use App\Http\Api\TitleObject;
use App\Models\Movie;
use App\Models\MovieAka;
use App\Models\Principal;
use App\Models\Rating;
use Illuminate\Http\Request;

class GetTitleController extends BaseController
{
    public function getByTitle(Request $request, $id)
    {
        $movie = Movie::findOrFail($id);

        return $this->sendResponse($request->format, new TitleObject($movie->tconst));
    }
}
