<?php

namespace App\Http\Controllers;

use App\Http\Resources\PrincipalResource;
use App\Models\Principal;

class PrincipalController extends Controller
{
    /**
     * @OA\Get(
     *     path="/principals/{principal}",
     *     tags={"Principals"},
     *     summary="Find principal by ID",
     *     description="Returns a single principal",
     *     operationId="getPrincipalById",
     *     @OA\Parameter(
     *         name="principal",
     *         in="path",
     *         description="ID of principal to return",
     *         required=true,
     *         @OA\Schema(
     *             type="integer",
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Successful operation",
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Principal not found"
     *     ),
     * )
     *
     * @param Principal $principal
     */
    public function show(Principal $principal)
    {
        return new PrincipalResource($principal->loadMissing(['movie', 'person']));
    }
}
