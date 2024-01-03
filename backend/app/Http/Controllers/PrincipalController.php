<?php

namespace App\Http\Controllers;

use App\Http\Resources\PrincipalResource;
use App\Models\Principal;

class PrincipalController extends Controller
{
    public function show(Principal $principal)
    {
        return new PrincipalResource($principal->loadMissing(['movie', 'person']));
    }
}
