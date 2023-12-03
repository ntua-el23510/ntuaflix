<?php

namespace App\Http\Controllers;

use App\Http\Api\NameObject;
use App\Models\Person;
use Illuminate\Http\Request;

class GetContributorByNameController extends BaseController
{
    /**
     * Handle the incoming request.
     */
    public function __invoke(Request $request, $id)
    {
        $contributor = Person::findOrFail($id);
        $nameObject = new NameObject($contributor->nconst);

        return $this->sendResponse($request->format, $nameObject);
    }
}
