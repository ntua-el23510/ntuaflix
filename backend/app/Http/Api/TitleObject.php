<?php

namespace App\Http\Api;

use App\Models\Movie;
use App\Models\MovieAka;
use App\Models\Principal;
use App\Models\Rating;
use Illuminate\Support\Collection;

class TitleObject
{
    private string $titleID;

    private string $type;

    private string $originalTitle;

    private ?string $titlePoster;

    private string $startYear;

    private ?string $endYear;

    private array $genres;

    private Collection $titleAkas;

    private Collection $principals;

    private array $rating;

    public function __construct(string $id)
    {
        $movie = Movie::findOrFail($id);
        $aka = MovieAka::where('titleId', $movie->tconst)->get();
        $principals = Principal::where('tconst', $movie->tconst)->with('person')->get();
        $rating = Rating::firstWhere('tconst', $movie->tconst);
        $data = [
            'titleID' => $movie->tconst,
            'type' => $movie->titleType,
            'originalTitle' => $movie->originalTitle,
            'titlePoster' => $movie->img_url_asset,
            'startYear' => (string) $movie->startYear,
            'endYear' => (string) $movie->endYear,
            'genres' => stringToObject($movie->genres, 'genreTitle'),
            'titleAkas' => $aka->map(function ($item) {
                return [
                    'akaTitle' => $item->title,
                    'regionAbbrev' => (string) $item->region,
                ];
            }),
            'principals' => $principals->map(function ($item) {
                return [
                    'nameID' => $item->nconst,
                    'name' => $item->person->primaryName,
                    'category' => $item->category,
                ];
            }),
            'rating' => $rating ? [
                'avRating' => $rating->averageRating ?? null,
                'nVotes' => $rating->numVotes ? (string) $rating->numVotes : null,
            ] : null,
        ];
        $this->titleID = $data['titleID'];
        $this->type = $data['type'];
        $this->originalTitle = $data['originalTitle'];
        $this->titlePoster = $data['titlePoster'];
        $this->startYear = $data['startYear'];
        $this->endYear = $data['endYear'];
        $this->genres = $data['genres'];
        $this->titleAkas = $data['titleAkas'];
        $this->principals = $data['principals'];
        $this->rating = $data['rating'];
    }

    public function toArray(): array
    {
        return [
            'titleID' => $this->titleID,
            'type' => $this->type,
            'originalTitle' => $this->originalTitle,
            'titlePoster' => $this->titlePoster,
            'startYear' => $this->startYear,
            'endYear' => $this->endYear,
            'genres' => $this->genres,
            'titleAkas' => $this->titleAkas,
            'principals' => $this->principals,
            'rating' => $this->rating,
        ];
    }

    public function get_titleId()
    {
        return $this->titleID;
    }
}
