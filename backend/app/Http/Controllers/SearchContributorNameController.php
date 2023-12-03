<?php

namespace App\Http\Controllers;

use App\Http\Api\NameObject;
use App\Http\Requests\SearchContributorNameRequest;
use App\Models\Person;
use Illuminate\Http\Request;

class SearchContributorNameController extends BaseController
{
    /**
     * Handle the incoming request.
     */
    public function __invoke(SearchContributorNameRequest $request)
    {
        $request->validated();
        $builder = Person::query();
        $queryString = $request->validated('nqueryObject');
        $builder->where('primaryName', 'LIKE', "%$queryString%");
        $searchContributor = $builder->get();
        $result = collect();
        foreach ($searchContributor as $contributor) {
            $result->push(new NameObject($contributor->nconst));
        }

        return $this->sendResponse('json', $result);
    }
}
