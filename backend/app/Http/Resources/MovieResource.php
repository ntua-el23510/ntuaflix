<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class MovieResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'tconst' => $this->tconst,
            'titleType' => $this->titleType,
            'primaryTitle' => $this->primaryTitle,
            'originalTitle' => $this->originalTitle,
            'isAdult' => $this->isAdult,
            'startYear' => $this->startYear,
            'endYear' => $this->endYear,
            'runtimeMinutes' => $this->runtimeMinutes,
            'genres' => $this->genres,
            'img_url_asset' => $this->img_url_asset,
            'rating' => $this->whenLoaded('rating'),
            'principals' => $this->whenLoaded('principals'),
            'alternativeTitles' => $this->whenLoaded('alternativeTitles'),
            'reviews' => $this->whenLoaded('reviews'),
        ];
    }
}
