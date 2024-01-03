<?php

namespace App\Http\Controllers;

use App\Http\Resources\PrincipalResource;
use App\Models\Principal;
use Illuminate\Http\Request;

class PrincipalController extends Controller
{
    public function show(Principal $principal)
    {
        return new PrincipalResource($principal->loadMissing(['movie', 'person']));
    }
}
