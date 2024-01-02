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
    /**
     * @OA\Get (
     * path="/title/{title_id}",
     * operationId="getMovieByTitle",
     * tags={"Media"},
     * summary="Get by title",
     * description="Get movie information",
     * @OA\Parameter(
     *          name="id",
     *          description="Project id",
     *          required=true,
     *          in="path"
     *      ),
     * @OA\Response(
     *          response=200,
     *          description="successful operation"
     *       ),
     * @OA\Response(response=400, description="Bad request"),
     * @OA\Response(response=404, description="Resource Not Found"),
     */
    public function getByTitle(Request $request, string $id)
    {
        $movie = Movie::findOrFail($id);

        return $this->sendResponse($request->format, new TitleObject($movie->tconst));
    }
}
