<?php

namespace App\Http\Controllers;

use App\Http\Resources\PersonResource;
use App\Models\Person;

class PersonController extends Controller
{
    /**
     * @OA\Get(
     *     path="/people/{person}",
     *     tags={"People"},
     *     summary="Find person by ID",
     *     description="Returns a single person",
     *     operationId="getPersonById",
     *     @OA\Parameter(
     *         name="person",
     *         in="path",
     *         description="ID of person to return",
     *         required=true,
     *         @OA\Schema(
     *             type="string",
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Successful operation",
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Person not found"
     *     ),
     * )
     *
     * @param Person $person
     */
    public function show(Person $person)
    {
        return new PersonResource($person->loadMissing(['principals']));
    }
}
