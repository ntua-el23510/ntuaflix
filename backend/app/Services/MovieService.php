<?php

namespace App\Services;

use App\Models\Movie;
use App\Models\User;

class MovieService
{
    public function addRating(array $ratingData, Movie $movie)
    {
        $rating = $movie->rating;

        $oldAverage = $rating->averageRating;
        $numVotes = $rating->numVotes;  // Liczba głosów przed dodaniem nowego wyniku

        // Obliczenia
        $voteTotal = $oldAverage * $numVotes;
        $newVoteTotal = $ratingData['rating'] + $voteTotal;
        $neNumVotes = $numVotes + 1;

        // Nowa średnia
        $newAverage = $newVoteTotal / $neNumVotes;

        $rating->update([
            'averageRating' => $newAverage,
            'numVotes' => $numVotes,
        ]);

        if (! empty($ratingData['review'])) {
            $movie->reviews()->create([
                'rating' => $ratingData['rating'],
                'review' => $ratingData['review'],
            ]);
        }
    }

    public function assignStatus(array $statusData, User $user)
    {
        if ($user->userMoviesList()->wherePivot('movie_id', $statusData['movie_id'])->exists()) {
            $user->userMoviesList()->updateExistingPivot($statusData['movie_id'], [
                'status' => $statusData['status'],
            ]);
        } else {
            $user->userMoviesList()->attach($statusData['movie_id'], ['status' => $statusData['status']]);
        }
    }
}
