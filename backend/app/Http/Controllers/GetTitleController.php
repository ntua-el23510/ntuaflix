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
     * summary="Get by title",
     * description="URL from provider, get access token",
     * operationId="providerAccess",
     * tags={"Authentication"},
     * @OA\RequestBody(
     *    required=true,
     *    description="Pass provider name",
     *    @OA\JsonContent(
     *       required={"provider name"},
     *       @OA\Property(property="provider_name", type="string", example="github"),
     *    ),
     * ),
     * @OA\Response(
     *    response=422,
     *    description="Wrong credentials response",
     *    @OA\JsonContent(
     *       @OA\Property(property="message", type="string", example="Sorry, wrong email address or password. Please try again")
     *        )
     *     )
     * )
     */
    public function getByTitle(Request $request, $id)
    {
        $movie = Movie::findOrFail($id);

        return $this->sendResponse($request->format, new TitleObject($movie->tconst));
    }
}
