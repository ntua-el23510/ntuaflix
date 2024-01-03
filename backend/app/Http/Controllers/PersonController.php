<?php

namespace App\Http\Controllers;

use App\Http\Resources\PersonResource;
use App\Models\Person;

class PersonController extends Controller
{
    public function show(Person $person)
    {
        return new PersonResource($person->loadMissing(['principals']));
    }
}
