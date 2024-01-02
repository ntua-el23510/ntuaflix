<?php

namespace App\Services;

use App\Models\Movie;

class MovieService
{
    public function addRating(array $ratingData, Movie $movie)
    {
        $rating = $movie->rating;

        $oldAverage = $rating->averageRating;
        $numVotes = $rating->numVotes;  # Liczba głosów przed dodaniem nowego wyniku

        # Obliczenia
        $voteTotal = $oldAverage * $numVotes;
        $newVoteTotal = $ratingData['rating'] + $voteTotal;
        $neNumVotes = $numVotes + 1;

        # Nowa średnia
        $newAverage = $newVoteTotal / $neNumVotes;

        $rating->update([
            'averageRating' => $newAverage,
            'numVotes' => $numVotes
        ]);

        if (!empty($ratingData['review'])) {
            $movie->reviews()->create([
                'rating' => $ratingData['rating'],
                'review' => $ratingData['review']
            ]);
        }
    }
}
