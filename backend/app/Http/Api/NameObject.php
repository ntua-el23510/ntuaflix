<?php

namespace App\Http\Api;

use App\Models\Person;
use Illuminate\Support\Collection;

class NameObject
{
    private string $nameID;

    private string $name;

    private ?string $namePoster;

    private ?string $birthYr;

    private ?string $deathYr;

    private string $profession;

    private Collection $nameTitles;

    public function __construct(string $id)
    {
        $person = Person::with('principals')->findOrFail($id);
        $data = [
            'nameID' => $person->nconst,
            'name' => $person->primaryName,
            'namePoster' => $person->img_url_asset,
            'birthYr' => $person->birthYear,
            'deathYr' => $person->deathYear,
            'profession' => $person->primaryProfession,
            'nameTitles' => $person->principals->map(function ($principal) {
                return [
                    'titleID' => $principal->tconst,
                    'category' => $principal->category,
                ];
            }),
        ];
        $this->nameID = $data['nameID'];
        $this->name = $data['name'];
        $this->namePoster = $data['namePoster'];
        $this->birthYr = $data['birthYr'];
        $this->deathYr = $data['deathYr'];
        $this->profession = $data['profession'];
        $this->nameTitles = $data['nameTitles'];
    }

    public function toArray(): array
    {
        return [
            'nameID' => $this->nameID,
            'name' => $this->name,
            'namePoster' => $this->namePoster,
            'birthYr' => $this->birthYr,
            'deathYr' => $this->deathYr,
            'profession' => $this->profession,
            'nameTitles' => $this->nameTitles,
        ];
    }
}
